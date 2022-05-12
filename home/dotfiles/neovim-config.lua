-- All LSP
local key_opts = {noremap = true, silent = true}

vim.api.nvim_set_keymap('n', 'l1', '<cmd>LspStart<CR>', key_opts)
vim.api.nvim_set_keymap('n', 'l0', '<cmd>LspStop<CR>', key_opts)

local on_attach = function(_, bufnr)

    vim.api.nvim_set_keymap('n', '<space>e',
                            '<cmd>lua vim.diagnostic.open_float()<CR>', key_opts)
    vim.api.nvim_set_keymap('n', '[d',
                            '<cmd>lua vim.diagnostic.goto_prev()<CR>', key_opts)
    vim.api.nvim_set_keymap('n', ']d',
                            '<cmd>lua vim.diagnostic.goto_next()<CR>', key_opts)
    vim.api.nvim_set_keymap('n', '<space>q',
                            '<cmd>lua vim.diagnostic.setloclist()<CR>', key_opts)

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
                                '<cmd>lua vim.lsp.buf.rename()<CR>', key_opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca',
                                '<cmd>lua vim.lsp.buf.code_action()<CR>',
                                key_opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr',
                                '<cmd>lua vim.lsp.buf.references()<CR>',
                                key_opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f',
                                '<cmd>lua vim.lsp.buf.formatting()<CR>',
                                key_opts)
end

vim.lsp.handlers["textDocument/hover"] =
    vim.lsp.with(vim.lsp.handlers.hover, {max_width = 85})

-- HLS LSP
require('lspconfig')['hls'].setup {on_attach = on_attach}

-- Python LSP
require'lspconfig'.pylsp.setup {on_attach = on_attach}

-- Completion

-- https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#vim-vsnip
local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and
               vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col,
                                                                          col)
                   :match("%s") == nil
end

local feedkey = function(key, mode)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true),
                          mode, true)
end

local cmp = require('cmp')
cmp.setup {
    completion = {autocomplete = false},
    mapping = {
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif vim.fn["vsnip#available"](1) == 1 then
                feedkey("<Plug>(vsnip-expand-or-jump)", "")
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, {"i", "s"}),
        ["<S-Tab>"] = cmp.mapping(function()
            if cmp.visible() then
                cmp.select_prev_item()
            elseif vim.fn["vsnip#jumpable"](-1) == 1 then
                feedkey("<Plug>(vsnip-jump-prev)", "")
            end
        end, {"i", "s"}),
        ["<CR>"] = cmp.mapping.confirm {behavior = cmp.ConfirmBehavior.Select}
    },
    sources = cmp.config.sources({
        {name = 'buffer'}, {name = 'nvim_lsp'}, {name = 'vsnip'}
    })
}
