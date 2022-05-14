-- https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#vim-vsnip
function setupCompletion()

    local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and
                   vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(
                       col, col):match('%s') == nil
    end

    local feedkey = function(key, mode)
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true,
                                                             true), mode, true)
    end

    local cmp = require('cmp')

    cmp.setup {
        completion = {autocomplete = false},
        mapping = {
            ['<C-n>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                elseif vim.fn['vsnip#available'](1) == 1 then
                    feedkey('<Plug>(vsnip-expand-or-jump)', '')
                elseif has_words_before() then
                    cmp.complete()
                else
                    fallback()
                end
            end, {'i', 's'}),
            ['<C-p>'] = cmp.mapping(function()
                if cmp.visible() then
                    cmp.select_prev_item()
                elseif vim.fn['vsnip#jumpable'](-1) == 1 then
                    feedkey('<Plug>(vsnip-jump-prev)', '')
                end
            end, {'i', 's'}),
            ['<CR>'] = cmp.mapping.confirm {
                behavior = cmp.ConfirmBehavior.Select
            }
        },
        sources = cmp.config.sources({
            {name = 'buffer'}, {name = 'nvim_lsp'}, {name = 'vsnip'}
        })
    }
end
