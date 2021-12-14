{ config, pkgs, ... }:

let
  dotnet =
    (with pkgs.dotnetCorePackages; combinePackages [
      sdk_6_0
      sdk_5_0
      sdk_3_1
    ]);
in
{
  home = {
    packages = [ dotnet ];
    file =
      let
        # Workaround for .NET Core SDK installed with Nix (https://wiki.archlinux.org/index.php/.NET_Core)
        dotnet_root = "export DOTNET_ROOT=${dotnet}\n";
        dotnet_tools = "PATH=$PATH:${config.home.homeDirectory}/.dotnet/tools\n";
      in
      {
        ".bashrc".text = dotnet_root + dotnet_tools;
        ".profile".text = dotnet_root + dotnet_tools;
      };
  };
}
