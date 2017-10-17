{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.github-ipfs;

in {
  options = {
    services.github-ipfs = {
      enable = mkEnableOption "Enable github-ipfs service."; 

      key = mkOption {
        type = types.str;
        default = "none";
        description = "GitHub Webhook secret";
      };

      path = mkOption {
        type = types.str;
        default = "/registry";
        description = "Absolute registry path in container";
      };

      port = mkOption {
        type = types.int;
        default = 8000;
        description = "Webhook port";
      };
    };
  };

  config = mkIf cfg.enable {
    systemd.services.github-ipfs = {
      after    = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];
      environment.variables = {
        REGISTRY_KEY = cfg.key;
        REGISTRY_PATH = cfg.path;
        PORT = cfg.port;
      };
      serviceConfig = {
        ExecStart = with lib.strings; "${pkgs.github-ipfs}/bin/github-ipfs";
        ExecStop = "${pkgs.coreutils}/bin/kill -INT $MAINPID";
        Restart = "on-failure";
      };
    };
  };
}