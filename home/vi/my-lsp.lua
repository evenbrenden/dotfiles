function SetupLSP(key_opts)

    local on_attach = function(_, bufnr)

        vim.api.nvim_set_keymap('n', '<Space>e',
                                ':lua vim.diagnostic.open_float()<CR>', key_opts)
        vim.api.nvim_set_keymap('n', '[d',
                                ':lua vim.diagnostic.goto_prev()<CR>', key_opts)
        vim.api.nvim_set_keymap('n', ']d',
                                ':lua vim.diagnostic.goto_next()<CR>', key_opts)
        vim.api.nvim_set_keymap('n', '<Space>q',
                                ':lua vim.diagnostic.setloclist()<CR>', key_opts)

        -- Note that \n has the digraph LF and is printed as ^@ in completion items
        vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD',
                                    ':lua vim.lsp.buf.declaration()<CR>',
                                    key_opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd',
                                    ':lua vim.lsp.buf.definition()<CR>',
                                    key_opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K',
                                    ':lua vim.lsp.buf.hover()<CR>', key_opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi',
                                    ':lua vim.lsp.buf.implementation()<CR>',
                                    key_opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>',
                                    ':lua vim.lsp.buf.signature_help()<CR>',
                                    key_opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Space>wa',
                                    ':lua vim.lsp.buf.add_workspace_folder()<CR>',
                                    key_opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Space>wr',
                                    ':lua vim.lsp.buf.remove_workspace_folder()<CR>',
                                    key_opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Space>wl',
                                    ':lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>',
                                    key_opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Space>D',
                                    ':lua vim.lsp.buf.type_definition()<CR>',
                                    key_opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Space>rn',
                                    ':lua vim.lsp.buf.rename()<CR>', key_opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Space>ca',
                                    ':lua vim.lsp.buf.code_action()<CR>',
                                    key_opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr',
                                    ':lua vim.lsp.buf.references()<CR>',
                                    key_opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Space>f',
                                    ':lua vim.lsp.buf.formatting()<CR>',
                                    key_opts)
    end

    -- https://www.reddit.com/r/neovim/comments/tx40m2/is_it_possible_to_improve_lsp_hover_look/
    vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
                                                 vim.lsp.handlers.hover,
                                                 {max_width = 85})

    local lspconfig = require 'lspconfig'
    lspconfig.hls.setup {on_attach = on_attach}
    lspconfig.metals.setup {on_attach = on_attach}
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
    lspconfig.tsserver.setup {
        on_attach = on_attach,
        cmd = {
            'typescript-language-server', '--stdio', '--tsserver-path',
            'tsserver'
        }
    }
end
