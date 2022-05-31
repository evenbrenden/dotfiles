{ pkgs, home-manager, system, stateVersion }: {
  # Make all home-manager configuration permutations of users and configs
  mkHomeConfigs = users: configs:
    let
      mkUsername = x: { username = x; };
      # [ { username = "user"; } ]
      usernames = map (x: { username = x; }) users;
      mkUserConfigs = username: map (x: x // username) configs;
      # [ { username = "username"; label ="label"; config = ./config; } ]
      usersConfigs = pkgs.lib.flatten (map mkUserConfigs usernames);
      mkHomeConfig = x: {
        name = "${x.username}-${x.label}";
        value = home-manager.lib.homeManagerConfiguration {
          inherit pkgs system stateVersion;
          username = x.username;
          homeDirectory = "/home/${x.username}";
          configuration = x.config;
        };
      };
      # { "username-label" = ...; }
      homeConfigs = builtins.listToAttrs (map mkHomeConfig usersConfigs);
    in homeConfigs;
}
