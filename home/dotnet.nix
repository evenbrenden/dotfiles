{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    dotnet-sdk_5
  ];

  home.file =
    let
      # Workaround for .NET Core SDK installed with Nix (https://wiki.archlinux.org/index.php/.NET_Core)
      dotnet_root = "export DOTNET_ROOT=${pkgs.dotnet-sdk_5}\n";
      dotnet_tools = "PATH=$PATH:${config.home.homeDirectory}/.dotnet/tools\n";
    in
    {
      ".bashrc".text = dotnet_root + dotnet_tools;
      ".profile".text = dotnet_root + dotnet_tools;
    };
}
