{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.websocket-star;
in

{

  ###### interface

  options = {

    services.websocket-star = {

      enable = mkEnableOption "Enable LibP2P WebSocket star service"; 

      port = mkOption {
        type = types.int;
        default = 9090;
        description = "Specify a port number server to listen to. Default: 9090";
      };
    };

  };


  ###### implementation

  config = mkIf config.services.websocket-star.enable {

    systemd.services.seeks =
      {
        description = "LibP2P WebSocket star";
        after = [ "network.target" ];
        wantedBy = [ "multi-user.target" ];
        serviceConfig = {
          User = "nobody";
          ExecStart = "${pkgs.nodePackages.libp2p-websocket-star-rendezvous}/bin/rendezvous --port ${toString cfg.port}";
          Restart = "always";
        };
      };

  };

}
