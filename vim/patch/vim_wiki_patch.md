# Vimwiki resolve_link Patch

- Vimwiki uses `$HOME/.config/nvim/plugged/vimwiki/autoload/vimwiki/base.vim` resolve_link function to resolve file path, internal link, etc

- In the resolve_link function, file ext ('.md') is always appended to file name

  ```vim
  function! vimwiki#base#resolve_link(link_text, ...) abort
    " ...
    " Check if a .md must be added
    " See #1271 to modify files with a "."
    let do_add_ext = ext ==? ''
    if vimwiki#vars#get_syntaxlocal('open_link_add_ext')
      let do_add_ext = do_add_ext || ext_with_dot !=? vimwiki#vars#get_wikilocal('ext', link_infos.index)
    endif

    " Add the dot
    if do_add_ext
      let link_infos.filename .= vimwiki#vars#get_wikilocal('ext', link_infos.index)
    endif
    " ...
  endfunction
  ```

- This works good for internal links, markdown files, but bad for other files like image etc.

- Therefore I add a new patch to prevent appending `.md` ext by checking if the file ext is well known like jpg, png, pdf etc.

  - Origin

    ```vim
    " Add the dot
    if do_add_ext
      let link_infos.filename .= vimwiki#vars#get_wikilocal('ext', link_infos.index)
    endif
    ```

  - Patched

    ```vim
    " ONLY add the dot for ambiguous file ext ()
    let nonambiguous_extensions = ['.png', '.jpg', '.jpeg', '.pdf', '.gif', '.bmp']
    if index(nonambiguous_extensions, ext_with_dot) == -1
      " Add the dot
      if do_add_ext
        let link_infos.filename .= vimwiki#vars#get_wikilocal('ext', link_infos.index)
      endif
    endif
    ```
