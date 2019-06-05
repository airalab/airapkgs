{ config, ... }:

let
  web3_http_provider = "https://sidechain.aira.life/rpc";
  web3_ws_provider = "wss://sidechain.aira.life/ws";
  lighthouse = "airalab.lighthouse.5.robonomics.sid";
  factory = "factory.5.robonomics.sid";
  graph_topic = "graph.5.robonomics.sid";
  token = "xrt.5.robonomics.sid";
  ens = "0xaC4Ac4801b50b74aa3222B5Ba282FF54407B3941";

in {
  # Enable light robot liability service
  services.liability = {
    enable = true;
    inherit ens web3_http_provider web3_ws_provider lighthouse factory graph_topic;
  };

  # Set params for XRT
  services.erc20 = {
    enable = true;
    inherit ens web3_http_provider web3_ws_provider token factory;
  };

  # enable separated roscore nodes
  services.roscore = {
    enable = true;
  };

}
