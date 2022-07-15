(self: super: {
  neovim-unwrapped = super.neovim-unwrapped.overrideAttrs (_: rec {
    pname = "neovim-unwrapped";
    version = "0.8.0-dev";

    src = super.fetchFromGitHub {
      owner = "neovim";
      repo = "neovim";
      rev = "9370e1c5111ee90f64260398b0623da4759f8f16";
      sha256 = "sha256-EsXsNEee5Ca9XPPAsFt9U6uoMw5McEvkgqjkTmh57qA=";
    };
  });
})
