{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.ipfs-subscriber;

in {
  options = {
    services.ipfs-subscriber = {
      enable = mkEnableOption "Robonomics.network provider daemon.";

      web3_provider = mkOption {
        type = types.str;
        default = "";
        description = "Web3 provider URI";
      };

      ipfs_provider = mkOption { 
        type = types.str;
        default = "";
        description = "IPFS provider multiaddress";
      };

      factory = mkOption {
        type = types.str;
        default = "";
        description = "Factory ENS";
      };

      ens = mkOption {
        type = types.str;
        default = "";
        description = "ENS registry address";
      };
      sid = {
        enable = mkOption {

          partOf = optional cfg.sid.enable "ipfs-subscriber-sid.service" ;
          wantedBy = [ "multi-user.target" ];

          path = with pkgs; [ bash getent ipfs ];

          script = ''
            ${pkgs.robonomics-tools}/bin/ipfs-subscriber ${optionalString (cfg.web3_provider != "") "--web3 \"${cfg.web3_provider}\""} ${optionalString (cfg.ipfs_provider != "") "--ipfs \"${cfg.ipfs_provider}\""} ${optionalString (cfg.factory!= "") "--factory \"${cfg.factory}\""} ${optionalString (cfg.ens != "") "--ens \"${cfg.ens}\""} 
          '';

          serviceConfig = {
            Restart = "on-failure";
            RestartSec = 5;
          };
        };
        ipfs-subscriber-sid = mkIf cfg.sid.enable {
          requires = [ "ipfs.service" "ipfs-subscriber.service" ];
          after = [ "ipfs.service" ];
          wantedBy = [ "multi-user.target" ];

          path = with pkgs; [ bash getent ipfs ];

          script = ''
            ${pkgs.robonomics-tools}/bin/ipfs-subscriber ${optionalString (cfg.sid.web3_provider != "") "--web3 \"${cfg.sid.web3_provider}\""} ${optionalString (cfg.sid.ipfs_provider != "") "--ipfs \"${cfg.sid.ipfs_provider}\""} ${optionalString (cfg.sid.factory!= "") "--factory \"${cfg.sid.factory}\""} ${optionalString (cfg.sid.ens != "") "--ens \"${cfg.sid.ens}\""} 
          '';

          serviceConfig = {
            Restart = "on-failure";
            RestartSec = 5;
          };
        };
      };
    };
  };
}
