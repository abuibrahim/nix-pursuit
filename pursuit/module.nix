{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.pursuit;
  pursuit = pkgs.haskellPackages.callPackage ./default.nix { };

in
{
  options.services.pursuit = {
    enable = mkEnableOption "Pursuit";

    user = mkOption {
      type = types.str;
      default = "pursuit";
      description = "User which runs Pursuit.";
    };

    group = mkOption {
      type = types.str;
      default = "pursuit";
      description = "Group which runs Pursuit.";
    };

    home = mkOption {
      type = types.str;
      default = "/var/lib/pursuit";
      description = "Home directory of Pursuit.";
    };

    rootUrl = mkOption {
      type = types.str;
      default = "";
      description = "Root URL.";
    };

    github_client_id = mkOption {
      type = types.str;
      default = "";
      description = "GitHub Client ID";
    };

    github_client_secret = mkOption {
      type = types.str;
      default = "";
      description = "GitHub Client Secret";
    };

    # Is this still used?
    github_auth_token = mkOption {
      type = types.str;
      default = "";
      description = "GitHub Authentication Token";
    };

    client_session = mkOption {
     type = types.str;
      default = "";
      description = "Client Session";
    };

    min_psc_version = mkOption {
      type = types.str;
      default = "0.9.3";
      description = "Minimum PureScript Compiler Version";
    };
  };

  config = mkIf cfg.enable {
    users.extraUsers.pursuit = {
      isSystemUser = true;
      group = cfg.group;
      home = cfg.home;
    };

    users.extraGroups."${cfg.group}" = {};

    systemd.services.pursuit = {
      description = "Pursuit";
      wantedBy = [ "multi-user.target" ];
      after = [ "network.target" ];

      environment = {
        PURSUIT_DATA_DIR = cfg.home;
        PURSUIT_APPROOT = cfg.rootUrl;
        PURSUIT_MINIMUM_COMPILER_VERSION = cfg.min_psc_version;
        PURSUIT_GITHUB_CLIENT_ID = cfg.github_client_id;
        PURSUIT_GITHUB_CLIENT_SECRET = cfg.github_client_secret;
        PURSUIT_GITHUB_AUTH_TOKEN = cfg.github_auth_token;
        PURSUIT_CLIENT_SESSION = cfg.client_session;
      };

      preStart = ''
        mkdir -p ${cfg.home}/{config,verified}
        chown -R ${cfg.user}:${cfg.group} ${cfg.home}
      '';

      serviceConfig = {
        User = cfg.user;
        Group = cfg.group;
        PermissionsStartOnly = true;
        ExecStart = "${pursuit}/bin/pursuit";
      };
    };

    environment.systemPackages = [ pursuit ];
  };
}
