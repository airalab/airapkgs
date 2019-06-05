{ config, ... }:

let
  web3_http_provider = "https://mainnet.infura.io/v3/cd7368514cbd4135b06e2c5581a4fff7";
  web3_ws_provider = "wss://mainnet.infura.io/ws";
  lighthouse = "airalab.lighthouse.5.robonomics.eth";
  factory = "factory.5.robonomics.eth";
  graph_topic = "graph.5.robonomics.eth";
  token = "xrt.5.robonomics.eth";

in {
  # Enable light robot liability service
  services.liability = {
    enable = true;
    inherit web3_http_provider web3_ws_provider lighthouse factory graph_topic;
  };

  # Set params for XRT
  services.erc20 = {
    enable = true;
    inherit web3_http_provider web3_ws_provider token factory;
  };

  # enable separated roscore nodes
  services.roscore = {
    enable = true;
  };

}
