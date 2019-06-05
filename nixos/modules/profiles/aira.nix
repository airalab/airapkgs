{ config, ... }:

{

  # Use AIRA channel by default
  # https://github.com/airalab/aira/issues/43
  system.defaultChannel = "https://aira.life/channels/aira-stable";

  nix = {
    # Disable sandbox by default
    # https://github.com/airalab/aira/issues/67 
    useSandbox = false;

    binaryCaches = [
      https://cache.nixos.org
      https://aira.cachix.org
    ];

    binaryCachePublicKeys = [
      "aira.cachix.org-1:/5nHPqhVrtvt7KCk04I8cH/jETANk8BtPHWsEtcwU/M="
    ];
  };

  services = {
    # Enable IPFS network
    ipfs = {
      enable = true;
      extraFlags = [ "--enable-namesys-pubsub" ];
      extraConfig = {
        Bootstrap = [
          "/dnsaddr/bootstrap.aira.life/ipfs/QmdfQmbmXt6sqjZyowxPUsmvBsgSGQjm4VXrV7WGy62dv8"
          "/dnsaddr/bootstrap.aira.life/ipfs/QmPTFt7GJ2MfDuVYwJJTULr6EnsQtGVp8ahYn9NSyoxmd9"
          "/dnsaddr/bootstrap.libp2p.io/ipfs/QmNnooDu7bfjPFoTZYxMNLWUQJyrVwtbZg5gBMjTezGAJN"
          "/dnsaddr/bootstrap.libp2p.io/ipfs/QmQCU2EcMqAqQPR2i9bChDtGNJchTbq5TbXJJ16u19uLTa"
          "/dnsaddr/bootstrap.libp2p.io/ipfs/QmbLHAnMoJPWSCR5Zhtx6BHJX9KiKNN6tpvbUcqanj75Nb"
          "/dnsaddr/bootstrap.libp2p.io/ipfs/QmcZf59bWwK5XFi76CZX8cbJ4BhTzzA3gU1ZjYZcYW3dwt"
          "/dns4/1.pubsub.aira.life/tcp/4001/ipfs/QmdfQmbmXt6sqjZyowxPUsmvBsgSGQjm4VXrV7WGy62dv8"
          "/dns4/2.pubsub.aira.life/tcp/4001/ipfs/QmPTFt7GJ2MfDuVYwJJTULr6EnsQtGVp8ahYn9NSyoxmd9"
          "/ip4/104.131.131.82/tcp/4001/ipfs/QmaCpDMGvV2BGHeYERUEnRQAwe3N8SzbUtfsmvsqQLuvuJ"
          "/ip4/104.236.179.241/tcp/4001/ipfs/QmSoLPppuBtQSGwKDZT2M73ULpjvfd3aZ6ha4oFGL1KrGM"
          "/ip4/128.199.219.111/tcp/4001/ipfs/QmSoLSafTMBsPKadTEgaXctDQVcqN88CNLHXMkTNwMKPnu"
          "/ip4/104.236.76.40/tcp/4001/ipfs/QmSoLV4Bbm51jM9C4gDYZQ9Cy3U6aXMJDAbzgu2fzaDs64"
          "/ip4/178.62.158.247/tcp/4001/ipfs/QmSoLer265NRgSp2LA3dPaeykiS1J6DifTC88f5uVQKNAd"
          "/ip6/2604:a880:1:20::203:d001/tcp/4001/ipfs/QmSoLPppuBtQSGwKDZT2M73ULpjvfd3aZ6ha4oFGL1KrGM"
          "/ip6/2400:6180:0:d0::151:6001/tcp/4001/ipfs/QmSoLSafTMBsPKadTEgaXctDQVcqN88CNLHXMkTNwMKPnu"
          "/ip6/2604:a880:800:10::4a:5001/tcp/4001/ipfs/QmSoLV4Bbm51jM9C4gDYZQ9Cy3U6aXMJDAbzgu2fzaDs64"
          "/ip6/2a03:b0c0:0:1010::23:1001/tcp/4001/ipfs/QmSoLer265NRgSp2LA3dPaeykiS1J6DifTC88f5uVQKNAd"
          "/ip6/fc6c:99a2:171a:f36a:8cd0:cc6b:efb7:8bb4/tcp/4001/ipfs/QmeJXJyAxVjNyNnNEWm1aHFXLzvhq9uTgNbnWu2TAsbvnE"
          "/ip6/fcd5:9d3a:b122:3de1:2742:a3b7:c9c4:46d9/tcp/4001/ipfs/QmdfQmbmXt6sqjZyowxPUsmvBsgSGQjm4VXrV7WGy62dv8"
          "/ip6/fc3c:1940:5f81:6b6c:724b:99c6:abb7:35f9/tcp/4001/ipfs/QmPTFt7GJ2MfDuVYwJJTULr6EnsQtGVp8ahYn9NSyoxmd9"
        ];
      };
    };

    # Enable IPv6 mesh network
    cjdns = {
      enable = true;

      ETHInterface.bind = "all";
      UDPInterface = {
        bind = "0.0.0.0:42000";
        connectTo = {
          # AIRA project cjdns node
          "52.232.72.83:31259" = {
            password = "tt3yb4613wgh3sgfsgkg1fvk24k6hnk";
            publicKey = "jyl980gs5513dw5x19qp3khb6337ljsx3sgwbsmnsvvyb5jdcw90.k";
          };

          # akru personal cjdns node
          "95.216.202.55:53741" = {
            password = "cr36pn2tp8u91s672pw2uu61u54ryu8";
            publicKey = "35mdjzlxmsnuhc30ny4rhjyu5r1wdvhb09dctd1q5dcbq6r40qs0.k";
          };
        };
      };
    };
  };

  # Open cjdns daemon port
  networking.firewall.allowedUDPPorts = [ 42000 ];
}
