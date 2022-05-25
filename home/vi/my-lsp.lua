function SetupLSP(key_opts)

    local on_attach = function(_, bufnr)

        vim.api.nvim_set_keymap('n', '<space>e',
                                ':lua vim.diagnostic.open_float()<cr>', key_opts)
        vim.api.nvim_set_keymap('n', '[d',
                                ':lua vim.diagnostic.goto_prev()<cr>', key_opts)
        vim.api.nvim_set_keymap('n', ']d',
                                ':lua vim.diagnostic.goto_next()<cr>', key_opts)
        vim.api.nvim_set_keymap('n', '<space>q',
                                ':lua vim.diagnostic.setloclist()<cr>', key_opts)

        -- Note that \n has the digraph LF and is printed as ^@ in completion items
        vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD',
                                    ':lua vim.lsp.buf.declaration()<cr>',
                                    key_opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd',
                                    ':lua vim.lsp.buf.definition()<cr>',
                                    key_opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K',
                                    ':lua vim.lsp.buf.hover()<cr>', key_opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi',
                                    ':lua vim.lsp.buf.implementation()<cr>',
                                    key_opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<c-k>',
                                    ':lua vim.lsp.buf.signature_help()<cr>',
                                    key_opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa',
                                    ':lua vim.lsp.buf.add_workspace_folder()<cr>',
                                    key_opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr',
                                    ':lua vim.lsp.buf.remove_workspace_folder()<cr>',
                                    key_opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl',
                                    ':lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>',
                                    key_opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D',
                                    ':lua vim.lsp.buf.type_definition()<cr>',
                                    key_opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn',
                                    ':lua vim.lsp.buf.rename()<cr>', key_opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca',
                                    ':lua vim.lsp.buf.code_action()<cr>',
                                    key_opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr',
                                    ':lua vim.lsp.buf.references()<cr>',
                                    key_opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f',
                                    ':lua vim.lsp.buf.formatting()<cr>',
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
