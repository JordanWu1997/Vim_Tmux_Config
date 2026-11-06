" ============================================================================
" Patch for FZF
" ============================================================================
" Reference:
" -- https://github.com/junegunn/fzf.vim/issues/865

" ============================================================================
" Extra commands
" ============================================================================
" from https://github.com/phongnh/fzf-settings.vim/blob/master/plugin/fzf_settings.vim

function! s:warn(message) abort
    echohl WarningMsg
    echomsg a:message
    echohl None
    return 0
endfunction

function! s:fzf_bufopen(e) abort
    let list = split(a:e)
    if len(list) < 4
        return
    endif

    let [linenr, col, file_text] = [list[1], list[2]+1, join(list[3:])]
    let lines = getbufline(file_text, linenr)
    let path = file_text
    if empty(lines)
        if stridx(join(split(getline(linenr))), file_text) == 0
            let lines = [file_text]
            let path = bufname('%')
        elseif filereadable(path)
            let lines = ['buffer unloaded']
        else
            " Skip.
            return
        endif
    endif

    execute 'e '  . path
    call cursor(linenr, col)
endfunction

function! s:fzf_yank_sink(e) abort
    let @" = a:e
    echohl ModeMsg
    echo 'Yanked!'
    echohl None
endfunction

function! s:fzf_messages_source() abort
    return split(call('execute', ['messages']), '\n')
endfunction

function! s:fzf_messages(bang) abort
    let s:source = 'messages'
    call fzf#run(fzf#wrap('messages', {
                \ 'source':  s:fzf_messages_source(),
                \ 'sink':    function('s:fzf_yank_sink'),
                \ 'options': '+m --prompt "Messages> "',
                \ }, a:bang))
endfunction

command! -bang Messages call <SID>fzf_messages(<bang>0)

" Quickfix / location list pickers
" -- Each line starts with the entry number and a tab (hidden by
"    --with-nth); the sink jumps with :cc N / :ll N, so the list's current
"    entry follows (]q, <leader>qj continue from there) and any file name
"    (spaces, %, :) works
" -- The location list belongs to the window the picker was started from
function! s:fzf_list_lines(items) abort
    return map(copy(a:items), {i, v -> (i + 1) . "\t"
                \ . (v.bufnr ? bufname(v.bufnr) : '') . ':' . v.lnum . ':'
                \ . v.col . ':' . v.text})
endfunction

function! s:fzf_open_list_item(cmd, winid, line) abort
    let l:nr = str2nr(matchstr(a:line, '^\d\+'))
    if l:nr <= 0
        return
    endif
    if a:cmd ==# 'll'
        call win_gotoid(a:winid)
    endif
    execute a:cmd l:nr
    normal! zvzz
endfunction

function! s:fzf_list(cmd, bang) abort
    let l:loc = a:cmd ==# 'll'
    let l:items = l:loc ? getloclist(0) : getqflist()
    if empty(l:items)
        call s:warn(l:loc ? 'No location list items!' : 'No quickfix items!')
        return
    endif
    call fzf#run(fzf#wrap(l:loc ? 'location_list' : 'quickfix', {
                \ 'source': s:fzf_list_lines(l:items),
                \ 'sink':   function('s:fzf_open_list_item',
                \                    [a:cmd, win_getid()]),
                \ 'options': ['--layout=reverse-list', '--delimiter', "\t",
                \             '--with-nth', '2..', '--prompt',
                \             l:loc ? 'LocationList> ' : 'Quickfix> '],
                \ }, a:bang))
endfunction

command! -bang FZFQuickFix call s:fzf_list('cc', <bang>0)
command! -bang FZFLocList call s:fzf_list('ll', <bang>0)

function! s:fzf_yank_register(line) abort
    call setreg('"', getreg(a:line[7]))
    echohl ModeMsg
    echo 'Yanked!'
    echohl None
endfunction

function! s:fzf_get_registers() abort
    return split(call('execute', ['registers']), '\n')[1:]
endfunction

function! s:fzf_registers(bang) abort
    let s:source = 'registers'
    let items = s:fzf_get_registers()
    if len(items) == 0
        call s:warn('No register items!')
        return
    endif
    call fzf#run(fzf#wrap('registers', {
                \ 'source':  items,
                \ 'sink':    function('s:fzf_yank_register'),
                \ 'options': '--layout=reverse-list +m --prompt "Registers> "',
                \ }, a:bang))
endfunction

command! -bang Registers call s:fzf_registers(<bang>0)
"
" ============================================================================
" Jumps list
" ============================================================================
" from https://github.com/junegunn/fzf.vim/issues/865

" Lines are 'file:line:col: text' (the preview needs this format). The sink
" looks the chosen line up in the list it was built from and jumps by buffer
" number and position, so file names with spaces, % or : work, and so do
" buffers without a file name.

function! s:get_line(bufnr, lnum) abort
    let l:lines = getbufline(a:bufnr, a:lnum)
    return empty(l:lines) ? '' : trim(l:lines[0])
endfunction

" entries: [{'bufnr', 'lnum', 'col'}] (col 0-based, as in getjumplist())
function! s:fzf_locations(entries, prompt) abort
    let s:fzf_location_entries = a:entries
    let s:fzf_location_lines = map(copy(a:entries), {_, v ->
                \ bufname(v.bufnr) . ':' . v.lnum . ':' . (v.col + 1) . ': '
                \ . s:get_line(v.bufnr, v.lnum)})
    call fzf#run(fzf#vim#with_preview(fzf#wrap({
        \ 'source': s:fzf_location_lines,
        \ 'options': ['--delimiter', ':', '--prompt', a:prompt,
        \             '--bind', 'alt-a:select-all,alt-d:deselect-all',
        \             '--preview-window', '+{2}-/2'],
        \ 'sink': function('s:fzf_goto_location')})))
endfunction

function! s:fzf_goto_location(line) abort
    let l:idx = index(s:fzf_location_lines, a:line)
    if l:idx < 0
        return
    endif
    let l:entry = s:fzf_location_entries[l:idx]
    if l:entry.bufnr != bufnr('')
        execute 'buffer' l:entry.bufnr
    endif
    call cursor(l:entry.lnum, l:entry.col + 1)
    normal! zvzz
endfunction

" ============================================================================
" Jumps list
" ============================================================================
" from https://github.com/junegunn/fzf.vim/issues/865
" -- Newest first; jumps into buffers that no longer exist are skipped

function! s:fzf_jumps() abort
    let l:jumps = filter(reverse(copy(getjumplist()[0])),
                \ 'bufexists(v:val.bufnr)')
    if empty(l:jumps)
        call s:warn('Empty jump list!')
        return
    endif
    call s:fzf_locations(l:jumps, 'Jumps> ')
endfunction

command! FZFJumps call s:fzf_jumps()

" ============================================================================
" Change list
" ============================================================================
" from https://github.com/junegunn/fzf.vim/issues/865
" -- Changes in the current buffer, newest first

function! s:fzf_changes() abort
    let l:bufnr = bufnr('')
    let l:changes = map(reverse(copy(getchangelist()[0])),
                \ {_, v -> {'bufnr': l:bufnr, 'lnum': v.lnum, 'col': v.col}})
    if empty(l:changes)
        call s:warn('Empty change list!')
        return
    endif
    call s:fzf_locations(l:changes, 'Changes> ')
endfunction

command! FZFChanges call s:fzf_changes()

" ============================================================================
" FZF Buffer Delete
" ============================================================================
" from https://www.reddit.com/r/neovim/comments/mlqyca/fzf_buffer_delete/

function! s:list_buffers()
    redir => list
    silent ls
    redir END
    return split(list, "\n")
endfunction

" -- :bdelete (not :bwipeout), so marks and jumps into the buffer are kept
" -- Buffers with unsaved changes are skipped and listed (save them, or
"    :bdelete! N to drop the changes), instead of one E89 stopping all
function! s:delete_buffers(lines)
    let l:skipped = []
    for l:nr in map(copy(a:lines), {_, line -> str2nr(split(line)[0])})
        if getbufvar(l:nr, '&modified')
            call add(l:skipped, l:nr . ' ' . fnamemodify(bufname(l:nr), ':~:.'))
        else
            execute 'bdelete' l:nr
        endif
    endfor
    if !empty(l:skipped)
        call s:warn('Unsaved changes, not deleted: ' . join(l:skipped, ', '))
    endif
endfunction

command! FZFBD call fzf#run(fzf#wrap({
    \ 'source': s:list_buffers(),
    \ 'sink*': { lines -> s:delete_buffers(lines) },
    \ 'options': '--multi --bind alt-a:select-all,alt-d:deselect-all --prompt "Delete buffers> "'}))

" ============================================================================
" FZF Insert markdown link
" ============================================================================

" Insert markdown link from root
function! s:InsertMarkdownLinkFromRoot()
    " Step 1: Find root directory with index.md
    let l:current = expand('%:p:h')
    let l:root = l:current
    while !empty(l:root) && !filereadable(l:root . '/index.md')
        let l:parent = fnamemodify(l:root, ':h')
        if l:parent == l:root
            echoerr "index.md not found in any parent directory"
            return
        endif
        let l:root = l:parent
    endwhile
    " Step 2: Find all markdown files under root except index.md
    let l:cmd = 'find ' . shellescape(l:root) . " -type f -name '*.md' ! -name 'index.md'"
    let l:md_files = systemlist(l:cmd)
    if empty(l:md_files)
        echo "No markdown files found."
        return
    endif
    " Step 3: Use lambda to extract selected[0]
    let l:Callback = { selected_list -> s:InsertMarkdownLink(selected_list[0]) }
    " Step 4: Run fzf
    call fzf#run(fzf#vim#with_preview(fzf#wrap({
        \ 'source': l:md_files,
        \ 'sink*': l:Callback,
        \ 'options': '--prompt "Link> "'})))
endfunction

" Insert markdown link
function! s:InsertMarkdownLink(selected) abort
    " Current file directory
    let l:current_dir = expand('%:p:h')
    let l:absolute_target = fnamemodify(a:selected, ':p')
    " Relative path from current file to target
    let l:rel_path = fnamemodify(fnamemodify(l:absolute_target, ':~:.'), ':.')
    " Use system 'realpath --relative-to' for more reliable cross-dir calculation
    let l:rel_path = system('realpath --relative-to=' . shellescape(l:current_dir) . ' ' . shellescape(l:absolute_target))
    let l:rel_path = substitute(l:rel_path, '\n\+$', '', '')  " remove trailing newline
    " Markdown filename (without extension)
    let l:filename = fnamemodify(a:selected, ':t:r')
    " Final markdown link
    let l:markdown = '[' . l:filename . '](' . l:rel_path . ')'
    call feedkeys("i" . l:markdown . "\<Esc>", 'n')
endfunction

command! FZFMDInsert call s:InsertMarkdownLinkFromRoot()
