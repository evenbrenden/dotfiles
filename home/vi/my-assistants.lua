function SetupAssistants()
    -- Copilot
    vim.cmd.packadd("copilot.vim")
    vim.g.copilot_filetypes = {markdown = false, text = false}
end
