function SetupAssistants()
    vim.cmd.packadd("copilot.vim")
    vim.g.copilot_filetypes = {
        ["*"] = false,
        ["dockerfile"] = true,
        ["haskell"] = true,
        ["javascript"] = true,
        ["nix"] = true,
        ["python"] = true,
        ["scala"] = true,
        ["sh"] = true,
        ["typescript"] = true
    }
end
