(self: super: {
  neovim-unwrapped = super.neovim-unwrapped.overrideAttrs (_: rec {
    pname = "neovim-unwrapped";
    version = "0.7.2";

    src = super.fetchFromGitHub {
      owner = "neovim";
      repo = "neovim";
      rev = "e8ee6733926db83ef216497a1d660a173184ff39";
      sha256 = "sha256-eKKQNM02Vhy+3yL2QV+0FSEpcniEa5Aq6hkAUIgLo1k=";
    };
  });
})
