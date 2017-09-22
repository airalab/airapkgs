{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.railway-game;

in {

  options = {
    services.railway-game = {

      enable = mkEnableOption "Enable AIRA railway game.";

      market = {
        right = mkOption {
          type = types.str;
          default = "0xdb932a4421910720bd07efaac98d6e2bf36efe03";
          example = "0xdb932a4421910720bd07efaac98d6e2bf36efe03";
          description = "Right metrics market address.";
        };

        left = mkOption {
          type = types.str;
          default = "0x53868955eac3242e43a594968e18d0949a3de93f";
          example = "0x53868955eac3242e43a594968e18d0949a3de93f";
          description = "Left metrics market address.";
        };
      };

      user = mkOption {
        type = types.str;
        default = "aira";
        description = "User account under which game runs.";
      };

      group = mkOption {
        type = types.str;
        default = "aira";
        description = "Group account under which game runs.";
      };
    };
  };

  config = mkIf cfg.enable {
    systemd.services.railway-market-switch = {
      after    = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];
      requires = [ "parity.service" ];
      environment = {
        MARKET_RIGHT_ADDRESS = cfg.market.right;
        MARKET_LEFT_ADDRESS = cfg.market.left;
      };
      serviceConfig = {
        ExecStart = "${pkgs.railway-market-switch}/bin/market-switch";
        ExecStop = "${pkgs.coreutils}/bin/kill -INT $MAINPID";
        User = "${cfg.user}";
        Group = "${cfg.group}";
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
