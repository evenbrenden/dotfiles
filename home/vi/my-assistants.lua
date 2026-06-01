function SetupAssistants()
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
        ["rust"] = true,
        ["sh"] = true,
        ["typescript"] = true
    }
end
