-- raw-img.lua
function RawInline(el)
  if el.format:match('^html') and el.text:match('^%s*<img') then
    local doc = pandoc.read(el.text, 'html')
    return pandoc.utils.blocks_to_inlines(doc.blocks)
  end
end

function RawBlock(el)
  if el.format:match('^html') and el.text:match('<img') then
    return pandoc.read(el.text, 'html').blocks
  end
end
