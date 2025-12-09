function SetupAssistants()
    -- https://github.com/github/copilot.vim/issues/142
    vim.cmd.packadd("copilot.vim")
    vim.g.copilot_filetypes = {
        ["*"] = false,
        ["c"] = true,
        ["cpp"] = true,
        ["dockerfile"] = true,
        ["dot"] = true,
        ["haskell"] = true,
        ["javascript"] = true,
        ["lua"] = true,
        ["nix"] = true,
        ["python"] = true,
        ["sh"] = true,
        ["typescript"] = true
    }
end
