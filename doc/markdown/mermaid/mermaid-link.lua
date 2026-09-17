--[[
mermaid-ink.lua — render ```mermaid blocks with zero local dependencies.

    pandoc note.md -L mermaid-ink.lua -o note.pdf
    pandoc note.md -L mermaid-ink.lua -o note.docx
    pandoc note.md -L mermaid-ink.lua -o note.html -s --embed-resources

Each diagram is base64-encoded into a https://mermaid.ink/ image URL;
pandoc downloads it and embeds it in the output. Needs an internet
connection at build time, and sends the diagram text to a third-party
server -- use mermaid.lua (mermaid-cli) for anything confidential.

Attributes:  ```{.mermaid width=60% caption="流程圖" svg=1}
    width / height  passed through to the image
    caption         renders as a figure caption
    svg=1           request SVG instead of PNG

Environment:
    MERMAID_INK   base URL (default https://mermaid.ink),
                  e.g. http://localhost:3000 for a self-hosted instance
    MERMAID_BG    background colour (default !white; use transparent for none)
--]]

local HOST = os.getenv('MERMAID_INK') or 'https://mermaid.ink'
local BG   = os.getenv('MERMAID_BG')  or '!white'

local alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'

-- plain-Lua base64; no external library needed
local function base64(data)
  local out = (data:gsub('.', function(char)
    local bits, byte = '', char:byte()
    for i = 8, 1, -1 do
      bits = bits .. (byte % 2 ^ i - byte % 2 ^ (i - 1) > 0 and '1' or '0')
    end
    return bits
  end) .. '0000'):gsub('%d%d%d?%d?%d?%d?', function(chunk)
    if #chunk < 6 then return '' end
    local n = 0
    for i = 1, 6 do
      n = n + (chunk:sub(i, i) == '1' and 2 ^ (6 - i) or 0)
    end
    return alphabet:sub(n + 1, n + 1)
  end)
  return out .. ({ '', '==', '=' })[#data % 3 + 1]
end

local function url_safe(s)
  return (s:gsub('%+', '-'):gsub('/', '_'))
end

-- pandoc 2.x gives a plain table here, 3.x a pandoc.List; avoid :includes()
local function has_class(block, name)
  for _, c in ipairs(block.classes) do
    if c == name then return true end
  end
  return false
end

-- first Para/Plain of the parsed caption, as inlines
local function caption_inlines(s)
  local ok, doc = pcall(pandoc.read, s, 'markdown')
  if ok then
    local b = doc.blocks[1]
    if b and (b.t == 'Para' or b.t == 'Plain') then return b.content end
  end
  return { pandoc.Str(s) }
end

function CodeBlock(block)
  if not has_class(block, 'mermaid') then
    return nil
  end

  local payload = url_safe(base64(block.text))
  local endpoint = block.attributes['svg'] and '/svg/' or '/img/'
  local url = HOST .. endpoint .. payload .. '?bgColor=' .. BG
  if not block.attributes['svg'] then
    url = url .. '&type=png'
  end

  local attrs = {}
  for _, k in ipairs({ 'width', 'height' }) do
    if block.attributes[k] then attrs[k] = block.attributes[k] end
  end
  local attr = pandoc.Attr(block.identifier or '', {}, attrs)

  local caption = block.attributes['caption']

  if caption then
    local cap = caption_inlines(caption)
    if pandoc.Figure then                      -- pandoc >= 3.0
      return pandoc.Figure(pandoc.Plain({ pandoc.Image({}, url, '', attr) }),
                           { pandoc.Plain(cap) })
    end
    -- pandoc 2.x: implicit figure, signalled by the "fig:" title
    return pandoc.Para({ pandoc.Image(cap, url, 'fig:', attr) })
  end
  return pandoc.Para({ pandoc.Image({}, url, '', attr) })
end
