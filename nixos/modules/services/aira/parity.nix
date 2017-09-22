{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.parity;

in {

  options = {
    services.parity = {

      enable = mkEnableOption "Enable Parity node service.";

      warp = mkOption {
        type = types.bool;
        default = true;
        description = "Enable WARP syncronisation.";
      };

      chain = mkOption {
        type = types.str;
        default = "mainnet";
        description = "User blockchain network.";
      };

      user = mkOption {
        type = types.str;
        default = "parity";
        description = "User account under which service runs.";
      };

      group = mkOption {
        type = types.str;
        default = "parity";
        description = "Group account under which service runs.";
      };

      extraOptions = mkOption {
        type = types.listOf types.str;
        default = [];
        example = [ "-v" ];
        description = ''
          Additional command-line arguments to pass to
          <command>parity</command>.
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    systemd.services.parity = {
      after    = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        ExecStart = with lib.strings; ''
          ${pkgs.parity}/bin/parity --chain ${cfg.chain} \
          ${optionalString cfg.warp "--warp"} \
          ${concatStringsSep " " cfg.extraOptions}
        '';
        ExecStop = "${pkgs.coreutils}/bin/kill -INT $MAINPID";
        User = cfg.user;
        Group = cfg.group;
        Restart = "always";
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
