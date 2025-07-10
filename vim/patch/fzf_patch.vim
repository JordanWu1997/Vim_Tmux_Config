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

function! s:fzf_open_quickfix_item(e) abort
    let line = a:e
    let filename = fnameescape(split(line, ':\d\+:')[0])
    let linenr = matchstr(line, ':\d\+:')[1:-2]
    let colum = matchstr(line, '\(:\d\+\)\@<=:\d\+:')[1:-2]
    execute 'e ' . filename
    call cursor(linenr, colum)
endfunction

function! s:fzf_quickfix_to_grep(v) abort
    return bufname(a:v.bufnr) . ':' . a:v.lnum . ':' . a:v.col . ':' . a:v.text
endfunction

function! s:fzf_get_quickfix() abort
    return map(getqflist(), 's:fzf_quickfix_to_grep(v:val)')
endfunction

function! s:fzf_quickfix(bang) abort
    let s:source = 'quickfix'
    let items = s:fzf_get_quickfix()
    if len(items) == 0
        call s:warn('No quickfix items!')
        return
    endif
    call fzf#run(fzf#wrap('quickfix', {
                \ 'source': items,
                \ 'sink':   function('s:fzf_open_quickfix_item'),
                \ 'options': '--layout=reverse-list --prompt "Quickfix> "'
                \ }, a:bang))
endfunction

function! s:fzf_get_location_list() abort
    return map(getloclist(0), 's:fzf_quickfix_to_grep(v:val)')
endfunction

function! s:fzf_location_list(bang) abort
    let s:source = 'location_list'
    let items = s:fzf_get_location_list()
    if len(items) == 0
        call s:warn('No location list items!')
        return
    endif
    call fzf#run(fzf#wrap('location_list', {
                \ 'source': items,
                \ 'sink':   function('s:fzf_open_quickfix_item'),
                \ 'options': '--layout=reverse-list --prompt "LocationList> "'
                \ }, a:bang))
endfunction

command! -bang Quickfix call s:fzf_quickfix(<bang>0)
command! -bang LocationList call s:fzf_location_list(<bang>0)

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

function GoTo(jumpline)
    let values = split(a:jumpline, ":")
    execute "e ".values[0]
    call cursor(str2nr(values[1]), str2nr(values[2]))
    execute "normal zvzz"
endfunction

function GetLine(bufnr, lnum)
    let lines = getbufline(a:bufnr, a:lnum)
    if len(lines)>0
        return trim(lines[0])
    else
        return ''
    endif
endfunction

function Getjumps()
    let jumps = []
    let raw_jumps = reverse(copy(getjumplist()[0]))
    for it in raw_jumps
        if bufexists(it.bufnr)
            call add(jumps, it)
        endif
    endfor
    return jumps
endfunction

function! Jumps()
    " Get jumps with filename added
    let tmp_jump = Getjumps()
    if(tmp_jump == [])
          call s:warn('Empty jump list!')
          return
    endif
    let jumps = map(Getjumps(),
        \ { key, val -> extend(val, {'fname': getbufinfo(val.bufnr)[0].name }) })

    let jumptext = map(copy(jumps), { index, val ->
        \ (val.fname).':'.(val.lnum).':'.(val.col+1).': '.GetLine(val.bufnr, val.lnum) })

    call fzf#run(fzf#vim#with_preview(fzf#wrap({
        \ 'source': jumptext,
        \ 'column': 1,
        \ 'options': ['--delimiter', ':', '--bind', 'alt-a:select-all,alt-d:deselect-all', '--preview-window', '+{2}-/2'],
        \ 'sink': function('GoTo')})))
endfunction

command! FZFJumps call Jumps()

" ============================================================================
" Change list
" ============================================================================
" from https://github.com/junegunn/fzf.vim/issues/865

function! Changes()
    let changes  = reverse(copy(getchangelist()[0]))
    if(changes == [])
        call s:warn('Empty change list!')
        return
    endif

    let changetext = map(copy(changes), { index, val ->
        \ expand('%').':'.(val.lnum).':'.(val.col+1).': '.GetLine(bufnr('%'), val.lnum) })

    call fzf#run(fzf#vim#with_preview(fzf#wrap({
        \ 'source': changetext,
        \ 'column': 1,
        \ 'options': ['--delimiter', ':', '--bind', 'alt-a:select-all,alt-d:deselect-all', '--preview-window', '+{2}-/2'],
        \ 'sink': function('GoTo')})))
endfunction

command! FZFChanges call Changes()

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

function! s:delete_buffers(lines)
    execute 'bwipeout' join(map(a:lines, {_, line -> split(line)[0]}))
endfunction

command! FZFBD call fzf#run(fzf#wrap({
    \ 'source': s:list_buffers(),
    \ 'sink*': { lines -> s:delete_buffers(lines) },
    \ 'options': '--multi --bind V:select-all'}))

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

command! FZFMDInsert call s:InsertMarkdownLinkFromRoot()<CR>
