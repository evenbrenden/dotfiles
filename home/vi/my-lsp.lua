function SetupLSP(key_opts)

    vim.api.nvim_set_keymap('n', 'l1', '<cmd>LspStart<CR>', key_opts)
    vim.api.nvim_set_keymap('n', 'l0', '<cmd>LspStop<CR>', key_opts)

    local on_attach = function(_, bufnr)

        vim.api.nvim_set_keymap('n', '<space>e',
                                '<cmd>lua vim.diagnostic.open_float()<CR>',
                                key_opts)
        vim.api.nvim_set_keymap('n', '[d',
                                '<cmd>lua vim.diagnostic.goto_prev()<CR>',
                                key_opts)
        vim.api.nvim_set_keymap('n', ']d',
                                '<cmd>lua vim.diagnostic.goto_next()<CR>',
                                key_opts)
        vim.api.nvim_set_keymap('n', '<space>q',
                                '<cmd>lua vim.diagnostic.setloclist()<CR>',
                                key_opts)

        -- https://github.com/haskell/haskell-language-server/pull/2848
        vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD',
                                    '<cmd>lua vim.lsp.buf.declaration()<CR>',
                                    key_opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd',
                                    '<cmd>lua vim.lsp.buf.definition()<CR>',
                                    key_opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K',
                                    '<cmd>lua vim.lsp.buf.hover()<CR>', key_opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi',
                                    '<cmd>lua vim.lsp.buf.implementation()<CR>',
                                    key_opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>',
                                    '<cmd>lua vim.lsp.buf.signature_help()<CR>',
                                    key_opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa',
                                    '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>',
                                    key_opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr',
                                    '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>',
                                    key_opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl',
                                    '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>',
                                    key_opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D',
                                    '<cmd>lua vim.lsp.buf.type_definition()<CR>',
                                    key_opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn',
                                    '<cmd>lua vim.lsp.buf.rename()<CR>',
                                    key_opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca',
                                    '<cmd>lua vim.lsp.buf.code_action()<CR>',
                                    key_opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr',
                                    '<cmd>lua vim.lsp.buf.references()<CR>',
                                    key_opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f',
                                    '<cmd>lua vim.lsp.buf.formatting()<CR>',
                                    key_opts)

        -- https://www.reddit.com/r/neovim/comments/tx40m2/is_it_possible_to_improve_lsp_hover_look/
        require'glow-hover'.setup {border = 'none', max_width = 85}
    end

    local lspconfig = require 'lspconfig'
    lspconfig.hls.setup {on_attach = on_attach}
    lspconfig.pylsp.setup {on_attach = on_attach}
    lspconfig.rnix.setup {on_attach = on_attach}
    lspconfig.sumneko_lua.setup {
        on_attach = on_attach,
        settings = {
            Lua = {
                runtime = {version = 'LuaJIT'},
                diagnostics = {globals = {'vim'}},
                workspace = {library = vim.api.nvim_get_runtime_file("", true)}
            }
        }
    }
end
