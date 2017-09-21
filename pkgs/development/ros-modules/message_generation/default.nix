{ pkgs, mkRosPackage, fetchFromGitHub }:

mkRosPackage {
  name = "message_generation";
  version = "0.4.0";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "message_generation-release";
    rev = "release/lunar/message_generation/0.4.0-0";
    sha256 = "0vnwr3jx0dapmyqgiy7h4qxkf837cv1wacqpxm5j10c864vmcrb3";
  };

  propagatedBuildInputs = with pkgs;
  [ catkin genmsg gencpp genpy genlisp geneus gennodejs ];
}
