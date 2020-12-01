{ config, pkgs, ... }:

{
  imports = [
    ../home-common.nix
  ];

  nixpkgs.overlays = [
    # JetBrains releases Rider quite often (so nixpkgs is usually behind)
    (import ../../overlays/jetbrains.rider.nix)
  ];

  home.packages = with pkgs; [
    dbeaver
    dotnet-sdk_5
    jetbrains.rider
    postman
    remmina
  ];

  home.file =
    let
      # Workaround for .NET Core SDK installed with Nix (https://wiki.archlinux.org/index.php/.NET_Core)
      dotnet_root = "export DOTNET_ROOT=${pkgs.dotnet-sdk_5}\n";
      dotnet_tools = "PATH=$PATH:${config.home.homeDirectory}/.dotnet/tools\n";
    in
    {
      ".bashrc".text =
        (builtins.readFile ../dotfiles/bashrc)
        + dotnet_root + dotnet_tools;
      ".profile".text = dotnet_root + dotnet_tools;
    };

  xdg.configFile."i3/config".text = with builtins;
    (readFile ../dotfiles/i3config-common)
    +
    (readFile ./dotfiles/i3config);
}
