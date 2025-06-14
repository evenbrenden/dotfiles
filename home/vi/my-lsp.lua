function SetupLSP(key_opts)
    local on_attach = function(_, bufnr)
        -- Basics
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Space>ca',
                                    ':lua vim.lsp.buf.code_action()<CR>',
                                    key_opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD',
                                    ':lua vim.lsp.buf.declaration()<CR>',
                                    key_opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd',
                                    ':lua vim.lsp.buf.definition()<CR>',
                                    key_opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Space>f',
                                    ':lua vim.lsp.buf.format()<CR>', key_opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K',
                                    ':lua vim.lsp.buf.hover()<CR>', key_opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi',
                                    ':lua vim.lsp.buf.implementation()<CR>',
                                    key_opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr',
                                    ':lua vim.lsp.buf.references()<CR>',
                                    key_opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Space>rn',
                                    ':lua vim.lsp.buf.rename()<CR>', key_opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>',
                                    ':lua vim.lsp.buf.signature_help()<CR>',
                                    key_opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Space>D',
                                    ':lua vim.lsp.buf.type_definition()<CR>',
                                    key_opts)

        -- Diagnostics
        vim.api.nvim_set_keymap('n', '<Space>e',
                                ':lua vim.diagnostic.open_float()<CR>', key_opts)
        vim.api.nvim_set_keymap('n', '[d',
                                ':lua vim.diagnostic.goto_prev()<CR>', key_opts)
        vim.api.nvim_set_keymap('n', ']d',
                                ':lua vim.diagnostic.goto_next()<CR>', key_opts)
        vim.api.nvim_set_keymap('n', '<Space>q',
                                ':lua vim.diagnostic.setloclist()<CR>', key_opts)

        -- Workspace
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Space>wa',
                                    ':lua vim.lsp.buf.add_workspace_folder()<CR>',
                                    key_opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Space>wr',
                                    ':lua vim.lsp.buf.remove_workspace_folder()<CR>',
                                    key_opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Space>wl',
                                    ':lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>',
                                    key_opts)

        -- Other
        vim.api.nvim_set_option_value('omnifunc', 'v:lua.vim.lsp.omnifunc',
                                      {buf = bufnr}) -- Note that \n has the digraph LF and is printed as ^@ in completion items
        vim.api.nvim_set_keymap('n', '<LocalLeader>s',
                                ':Telescope lsp_workspace_symbols<CR>', key_opts)
    end

    local lspconfig = require 'lspconfig'
    lspconfig.clangd.setup {on_attach = on_attach}
    lspconfig.hls.setup {on_attach = on_attach}
    lspconfig.idris2_lsp.setup {on_attach = on_attach} -- https://github.com/claymager/idris2-pkgs
    lspconfig.lua_ls.setup {
        on_attach = on_attach,
        settings = {
            Lua = {
                runtime = {version = 'LuaJIT'},
                diagnostics = {globals = {'vim'}},
                workspace = {library = vim.api.nvim_get_runtime_file("", true)}
            }
        }
    }
    lspconfig.nil_ls.setup {on_attach = on_attach}
    lspconfig.pylsp.setup {
        on_attach = on_attach,
        settings = {
            pylsp = {
                plugins = {pylsp_mypy = {enabled = true, live_mode = true}}
            }
        }
    }
    lspconfig.ts_ls.setup {
        on_attach = on_attach,
        cmd = {'typescript-language-server', '--stdio'}
    }
    lspconfig.yamlls.setup {}

    -- https://www.reddit.com/r/neovim/comments/tx40m2/is_it_possible_to_improve_lsp_hover_look/
    vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
                                                 vim.lsp.handlers.hover,
                                                 {max_width = 85})
end
