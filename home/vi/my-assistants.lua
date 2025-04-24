function SetupAssistants()
    vim.cmd.packadd("copilot.vim")
    vim.g.copilot_filetypes = {
        ["*"] = false,
        ["c"] = true,
        ["cpp"] = true,
        ["dockerfile"] = true,
        ["haskell"] = true,
        ["javascript"] = true,
        ["lua"] = true,
        ["nix"] = true,
        ["python"] = true,
        ["scala"] = true,
        ["sh"] = true,
        ["typescript"] = true
    }
end
