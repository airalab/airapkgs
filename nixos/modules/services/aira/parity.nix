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

      autoSign = {
        enable = mkOption {
          type = types.bool;
          default = true;
          description = "Create default account for sending transactions.";
        };

        passwordFile = mkOption {
          type = types.str;
          default = "/var/lib/parity/psk";
          description = "File to store account password file.";
        };
      };

      user = mkOption {
        type = types.str;
        default = "parity";
        description = "User account under which service runs.";
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
          export ACCOUNT=$(${pkgs.parity}/bin/parity account list | head -n 1)
          if [ $ACCOUNT -eq "" ]; then
            ${optionalString cfg.autoSign.enable "${pkgs.parity}/bin/parity account new --password ${cfg.autoSign.passwordFile}"}
            export ACCOUNT=$(${pkgs.parity}/bin/parity account list | head -n 1)
          fi
          ${pkgs.parity}/bin/parity --chain ${cfg.chain} \
          ${optionalString cfg.warp "--warp"} \
          ${optionalString cfg.autoSign.enable "--no-ui --unlock $ACCOUNT --password ${cfg.autoSign.passwordFile}"} \
          ${concatStringsSep " " cfg.extraOptions}
        '';
        ExecStop = "${pkgs.coreutils}/bin/kill -INT $MAINPID";
        Restart = "on-failure";
        User = cfg.user;
      };
    };

    users.extraUsers = singleton
      { name = cfg.user;
        home = "/var/lib/parity";
        createHome = true;
        isNormalUser = true;
      };
  };
}
