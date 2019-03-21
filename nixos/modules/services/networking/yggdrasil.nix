{ config, lib, pkgs, ... }:

with lib;

let

  pkg = pkgs.yggdrasil-go;
  cfg = config.services.yggdrasil;

  yggdrasilConf = builtins.toJSON ( {
    Peers =  cfg.Peers;
    InterfacePeers = cfg.InterfacePeers;
    Listen = cfg.Listen;
    AdminListen = cfg.AdminListen;
    MulticastInterfaces = cfg.MulticastInterfaces;
    AllowedEncryptionPublicKeys = cfg.AllowedEncryptionPublicKeys;
    EncryptionPublicKey = "@ENCRYPTION_PUBLIC_KEY@";
    EncryptionPrivateKey = "@ENCRYPTION_PRIVATE_KEY@";
    SigningPublicKey = "@SIGNING_PUBLIC_KEY@";
    SigningPrivateKey = "@SIGNING_PRIVATE_KEY@";
    LinkLocalTCPPort = cfg.LinkLocalTCPPort;
    IfName = cfg.IfName;
    IfTAPMode = cfg.IfTAPMode;
    IfMTU = cfg.IfMTU;
    SessionFirewall = {
      Enable = cfg.SessionFirewall.Enable;
      AllowFromDirect = cfg.SessionFirewall.AllowFromDirect;
      AllowFromRemote = cfg.SessionFirewall.AllowFromRemote;
      AlwaysAllowOutbound = cfg.SessionFirewall.AlwaysAllowOutbound;
      WhitelistEncryptionPublicKeys = cfg.SessionFirewall.WhitelistEncryptionPublicKeys;
      BlacklistEncryptionPublicKeys = cfg.SessionFirewall.BlacklistEncryptionPublicKeys;
    };
    TunnelRouting = {
      Enable = cfg.TunnelRouting.Enable;
      IPv6Destinations = cfg.TunnelRouting.IPv6Destinations;
      IPv6Sources = cfg.TunnelRouting.IPv6Sources;
      IPv4Destinations = cfg.TunnelRouting.IPv4Destinations;
      IPv4Sources = cfg.TunnelRouting.IPv4Sources;
    };
    SwitchOptions = {
      MaxTotalQueueSize = cfg.SwitchOptions.MaxTotalQueueSize;
    };
    NodeInfoPrivacy = cfg.NodeInfoPrivacy;
    NodeInfo = cfg.NodeInfo;
  });

in

{
  options = {

    services.yggdrasil = {

      enable = mkOption {
        type = types.bool;
        default = false;
        description = ''
          An experiment in scalable routing as an encrypted IPv6 overlay network https://yggdrasil-network.github.io
        '';
      };

      confFile = mkOption {
        type = types.nullOr types.path;
        default = null;
        example = "/etc/yggdrasil.conf";
        description = ''
          Ignore all other yggdrasil options and load configuration from this file.
        '';
      };

      Peers = mkOption {
        type = types.listOf types.str;
        default = [];
        description = ''
        '';
      };
      InterfacePeers = mkOption {
          type = types.attrsOf types.str;
          default = {};
          description = ''
            List of connection strings for outbound peer connections in URI format,
            arranged by source interface, e.g. { "eth0": [ tcp://a.b.c.d:e ] }
            Note that SOCKS peerings will NOT be affected by this option and should
            go in the "Peers" section instead.
          '';
        };
        Listen = mkOption {
          type = types.listOf types.str;
          default = [];
          description = ''
            Listen addresses for incoming connections. You will need to add
            listeners in order to accept incoming peerings from non-local nodes.
            Multicast peer discovery will work regardless of any listeners set
            here. Each listener should be specified in URI format as above, e.g.
            tcp://0.0.0.0:0 or tcp://[::]:0 to listen on all interfaces.
          '';
        };

        AdminListen = mkOption { 
          type = types.str;
          default = "unix:///var/run/yggdrasil.sock";
          description = ''
            Listen address for admin connections. Default is to listen for local
            connections either on TCP/9001 or a UNIX socket depending on your
            platform. Use this value for yggdrasilctl -endpoint=X. To disable
            the admin socket, use the value "none" instead.
          '';
        };

        MulticastInterfaces = mkOption {
          type = types.listOf types.str;
          default = [ ".*" ];
          description = ''
            Regular expressions for which interfaces multicast peer discovery
            should be enabled on. If none specified, multicast peer discovery is
            disabled. The default value is .* which uses all interfaces.
          '';
        };

        AllowedEncryptionPublicKeys = mkOption {
          type = types.listOf types.str;
          default = [];
          description = ''
            Regular expressions for which interfaces multicast peer discovery
            should be enabled on. If none specified, multicast peer discovery is
            disabled. The default value is .* which uses all interfaces.
          '';
        };

        LinkLocalTCPPort = mkOption { 
          type = types.int;
          default = 0;
          description = ''
            The port number to be used for the link-local TCP listeners for the 
            configured MulticastInterfaces. This option does not affect listeners
            specified in the Listen option. Unless you plan to firewall link-local
            traffic, it is best to leave this as the default value of 0. This
            option cannot currently be changed by reloading config during runtime.
          ''; 
        };
        IfName = mkOption {
          type = types.str;
          default = "auto";
          description = ''
            Local network interface name for TUN/TAP adapter, or "auto" to select
            an interface automatically, or "none" to run without TUN/TAP.
          '';
        };

        IfTAPMode = mkOption {
          type = types.bool;
          default = false;
          description = ''
            Set local network interface to TAP mode rather than TUN mode if
            supported by your platform - option will be ignored if not.
          '';
        };

        IfMTU = mkOption {
          type = types.int;
          default = 65535;
          description = ''
            Maximux Transmission Unit (MTU) size for your local TUN/TAP interface.
            Default is the largest supported size for your platform. The lowest
            possible value is 1280.
          '';
        };

      SessionFirewall = { 
        Enable = mkOption {
          type = types.bool;
          default = false;
          description = ''
            Enable or disable the session firewall. If disabled, network traffic
            from any node will be allowed. If enabled, the below rules apply.
          '';
        };

        AllowFromDirect = mkOption {
          type = types.bool;
          default = true;
          description = ''
            Allow network traffic from directly connected peers.
          '';
        };

        AllowFromRemote = mkOption {
          type = types.bool;
          default = true;
          description = ''
              Allow network traffic from remote nodes on the network that you are
            not directly peered with.
          '';
        };

        AlwaysAllowOutbound = mkOption {
          type = types.bool;
          default = true;
          description = ''
            Allow outbound network traffic regardless of AllowFromDirect or
            AllowFromRemote. This does allow a remote node to send unsolicited
            traffic back to you for the length of the session.
          '';
        };

        WhitelistEncryptionPublicKeys = mkOption {
          type = types.listOf types.str;
          default = [];
          description = ''
            List of public keys from which network traffic is always accepted,
            regardless of AllowFromDirect or AllowFromRemote.
          '';
        };

        BlacklistEncryptionPublicKeys = mkOption {
          type = types.listOf types.str;
          default = [];
          description = ''
            List of public keys from which network traffic is always rejected,
            regardless of the whitelist, AllowFromDirect or AllowFromRemote.
          '';
        };
      };

      TunnelRouting = { 
        Enable = mkOption {
          type = types.bool;
          default = false;
          description = ''
            Enable or disable tunnel routing.
          '';
        };

        IPv6Destinations = mkOption {
          type = types.attrsOf types.str;
          default = {};
          description = ''
            IPv6 CIDR subnets, mapped to the EncryptionPublicKey to which they
            should be routed, e.g. { "aaaa:bbbb:cccc::/e": "boxpubkey", ... }
          '';
        };

        IPv6Sources = mkOption {
          type = types.listOf types.str;
          default = [];
          description = ''
            Optional IPv6 source subnets which are allowed to be tunnelled in
            addition to this node's Yggdrasil address/subnet. If not
            specified, only traffic originating from this node's Yggdrasil
            address or subnet will be tunnelled.
          '';
        };

        IPv4Destinations = mkOption {
          type = types.attrsOf types.str;
          default = {};
          description = ''
            IPv4 CIDR subnets, mapped to the EncryptionPublicKey to which they
            should be routed, e.g. { "a.b.c.d/e": "boxpubkey", ... }
          '';
        };

        IPv4Sources = mkOption {
          type = types.listOf types.str;
          default = [];
          description = ''
            IPv4 source subnets which are allowed to be tunnelled. Unlike for
            IPv6, this option is required for bridging IPv4 traffic. Only
            traffic with a source matching these subnets will be tunnelled.
          '';
        };
      };

      SwitchOptions = {
        MaxTotalQueueSize = mkOption {
          type = types.int;
          default = 4194304;
          description = ''
            Maximum size of all switch queues combined (in bytes).
          '';
        };
      };

      NodeInfoPrivacy = mkOption {
        type = types.bool;
        default = false;
        description = ''
          By default, nodeinfo contains some defaults including the platform,
          architecture and Yggdrasil version. These can help when surveying
          the network and diagnosing network routing problems. Enabling
          nodeinfo privacy prevents this, so that only items specified in
          "NodeInfo" are sent back if specified.
        '';
      };

      NodeInfo = mkOption {
        type = types.attrsOf types.str;
        default = {};
        description = ''
          Optional node info. This must be a { "key": "value", ... } map
          or set as null. This is entirely optional but, if set, is visible
          to the whole network on request.
        '';
      };
    };

  };

  config = mkIf cfg.enable {

    boot.kernelModules = [ "tun" ];

    # networking.firewall.allowedUDPPorts = ...

      systemd.services.yggdrasil = {
      description = "yggdrasil";
      wantedBy = [ "multi-user.target" "sleep.target"];
      after = [ "network-online.target" ];
      bindsTo = [ "network-online.target" ];

      preStart = if cfg.confFile != null then "" else ''#!${pkgs.bash}/bin/bash
        if [ ! -f /etc/yggdrasil.priv -o ! -f /etc/yggdrasil.pub ]; then
          conf=`${pkg}/bin/yggdrasil -genconf -json`
          echo "ENCRYPTION_PRIVATE_KEY=`echo $conf| ${pkgs.jq}/bin/jq -r ".EncryptionPrivateKey"`" > /etc/yggdrasil.priv
          echo "SIGNING_PRIVATE_KEY=`echo $conf| ${pkgs.jq}/bin/jq -r ".SigningPrivateKey"`" >> /etc/yggdrasil.priv
          chmod 600 /etc/yggdrasil.priv
          echo "ENCRYPTION_PUBLIC_KEY=`echo $conf| ${pkgs.jq}/bin/jq -r ".EncryptionPublicKey"`" > /etc/yggdrasil.pub
          echo "SIGNING_PUBLIC_KEY=`echo $conf| ${pkgs.jq}/bin/jq -r ".SigningPublicKey"`" >> /etc/yggdrasil.pub
          chmod 444 /etc/yggdrasil.pub
        fi
      '';

      script = (
        if cfg.confFile != null then "${pkg}/bin/yggdrasil -useconffile ${cfg.confFile}" else ''
          source /etc/yggdrasil.priv
          source /etc/yggdrasil.pub
          echo '${yggdrasilConf}' | sed \
          -e "s/@ENCRYPTION_PRIVATE_KEY@/$ENCRYPTION_PRIVATE_KEY/g" \
          -e "s/@SIGNING_PRIVATE_KEY@/$SIGNING_PRIVATE_KEY/g" \
          -e "s/@ENCRYPTION_PUBLIC_KEY@/$ENCRYPTION_PUBLIC_KEY/g" \
          -e "s/@SIGNING_PUBLIC_KEY@/$SIGNING_PUBLIC_KEY/g" \
          | ${pkg}/bin/yggdrasil -useconf
        ''
      );

      serviceConfig = {
        Type = "forking";
        Restart = "always";
        StartLimitInterval = 0;
        RestartSec = 1;
        CapabilityBoundingSet = "CAP_NET_ADMIN CAP_NET_RAW CAP_SETUID";
        ProtectSystem = true;
        # Doesn't work on i686, causing service to fail
        MemoryDenyWriteExecute = !pkgs.stdenv.isi686;
        ProtectHome = true;
        PrivateTmp = true;
      };
    };
  };
}
