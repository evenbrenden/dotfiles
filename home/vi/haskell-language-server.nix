(self: super: {
  haskell-language-server = super.haskell-language-server.overrideAttrs
    (_: rec {
      pname = "haskell-language-server";
      version = "1.6.1.1";
      sha256 = "03z650zk7ma0gsmb7mirzarwg0535kwmwyf0h8a89s8bqfcd5mxf";
    });
})
