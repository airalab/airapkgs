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

  services.cjdns = {
    enable = true;

    ETHInterface.bind = "all";
    UDPInterface.bind = "0.0.0.0:42000";

    # AIRA project cjdns node
    UDPInterface.connectTo."52.232.72.83:31259" = {
      password = "tt3yb4613wgh3sgfsgkg1fvk24k6hnk";
      publicKey = "jyl980gs5513dw5x19qp3khb6337ljsx3sgwbsmnsvvyb5jdcw90.k";
    };

    # akru personal cjdns node
    UDPInterface.connectTo."164.132.111.49:53741" = {
      password = "cr36pn2tp8u91s672pw2uu61u54ryu8";
      publicKey = "35mdjzlxmsnuhc30ny4rhjyu5r1wdvhb09dctd1q5dcbq6r40qs0.k";
    };
  };

  # Open cjdns daemon port
  networking.firewall.allowedUDPPorts = [ 42000 ];

}
