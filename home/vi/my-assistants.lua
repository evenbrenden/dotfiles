function SetupAssistants()
    -- avante.nvim
    vim.cmd.packadd("avante.nvim")
    require("avante_lib").load()
    require("avante").setup({provider = "openai"})

    -- Copilot
    vim.cmd.packadd("copilot.vim")
    vim.g.copilot_filetypes = {markdown = false, text = false}
end
