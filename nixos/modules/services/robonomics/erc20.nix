{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.erc20;

  mainnetEns = "0x314159265dD8dbb310642f98f50C066173C1259b";
  liabilityHome = "/var/lib/liability";
  keyfile = "${liabilityHome}/keyfile";
  keyfile_password_file = "${liabilityHome}/keyfile-psk";

  python-eth_keyfile = pkgs.python3.withPackages (ps : with ps; [ eth-keyfile ]);

in {
  options = {
    services.erc20 = {
      enable = mkEnableOption "Enable Robonomics ERC20 service.";

      ens = mkOption {
        type = types.str;
        default = mainnetEns;
        description = "Ethereum name regustry address.";
      };

      user = mkOption {
        type = types.str;
        default = "liability";
        description = "User account under which service runs.";
      };

      keyfile = mkOption {
        type = types.str;
        default = keyfile;
        description = "Default keyfile for signing transactions.";
      };

      keyfile_password_file = mkOption {
        type = types.str;
        default = keyfile_password_file;
        description = "Password file for keyfile.";
      };

      web3_http_provider = mkOption {
        type = types.str;
        default = "https://mainnet.infura.io/v3/cd7368514cbd4135b06e2c5581a4fff7";
        description = "Web3 http provider address";
      };

      web3_ws_provider = mkOption {
        type = types.str;
        default = "wss://mainnet.infura.io/ws";
        description = "Web3 websocket provider address";
      };

    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ robonomics_comm ];

    systemd.services.erc20 = {
      wantedBy = [ "multi-user.target" ];

      preStart = ''
        if [ ! -e ${cfg.keyfile} ]; then
          PASSWORD=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | head -c32)
          echo $PASSWORD > ${cfg.keyfile_password_file}
          ${python-eth_keyfile}/bin/python -c "import os,eth_keyfile,json; print(json.dumps(eth_keyfile.create_keyfile_json(os.urandom(32), '$PASSWORD'.encode())))" > ${cfg.keyfile}
        fi
      '';

      script = ''
        source ${pkgs.robonomics_comm}/setup.bash \
          && roslaunch ethereum_common erc20.launch \
              ens_contract:="${cfg.ens}" \
              keyfile:="${cfg.keyfile}" \
              keyfile_password_file:="${cfg.keyfile_password_file}" \
              web3_http_provider:="${cfg.web3_http_provider}" \
              web3_ws_provider:="${cfg.web3_ws_provider}"
      '';

      serviceConfig = {
        Restart = "on-failure";
        StartLimitInterval = 0;
        RestartSec = 60;
        User = cfg.user;
      };
    };
  };
}
