return {
    'vimwiki/vimwiki',
    init = function () --replace 'config' with 'init'
        vim.g.vimwiki_list = {
            { path = '~/Documents/C-LINK', syntax = 'markdown', ext = '.md' },
            { path = '~/Documents/KNOWLEDGE_BASE/', syntax = 'markdown', ext = '.md' }
        }
    end
}
