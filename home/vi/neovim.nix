(self: super: {
  neovim-unwrapped = super.neovim-unwrapped.overrideAttrs (_: rec {
    pname = "neovim-unwrapped";
    version = "0.7.0";

    src = super.fetchFromGitHub {
      owner = "neovim";
      repo = "neovim";
      rev = "v${version}";
      sha256 = "sha256-eYYaHpfSaYYrLkcD81Y4rsAMYDP1IJ7fLJJepkACkA8=";
    };

    patches = [ ./0001-Use-Markdown-files-from-vim-markdown-concealed.patch ];
  });
})
