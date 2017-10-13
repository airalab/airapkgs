{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.aira-proto;

in {

  options = {
    services.aira-proto = {

      enable = mkEnableOption "Enable AIRA protocol node.";

      mode = mkOption {
        type = types.str;
        default = "validator";
        description = "AIRA protocol role: promisee, promisor or validator.";
      };

      user = mkOption {
        type = types.str;
        default = "aira-proto";
        description = "User account under which protocol runs.";
      };

      group = mkOption {
        type = types.str;
        default = "aira-proto";
        description = "Group account under which protocol runs.";
      };

      extraOptions = mkOption {
        type = types.listOf types.str;
        default = [];
        description = ''
          Additional command-line arguments to pass to
          <command>aira-proto</command>.
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    systemd.services.aira-proto= {
      after    = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];
      requires = [ "parity.service" ];
      environment = {};
      serviceConfig = {
        ExecStart = with lib.strings; ''
          source ${pkgs.ros_comm}/setup.sh
          ${pkgs.aira-proto}/bin/aira-proto \
          ${cfg.mode} \
          ${concatStringsSep " " cfg.extraOptions}
        '';
        ExecStop = "${pkgs.coreutils}/bin/kill -INT $MAINPID";
        User = "${cfg.user}";
        Group = "${cfg.group}";
        Restart = "on-failure";
        RestartSec = "30s";
        StartLimitBurst = "60";
      };
    };

    users.extraUsers = singleton
      { name = cfg.user;
        group = cfg.group;
      };

    users.extraGroups = singleton
      { name = cfg.group; };
  };
}
