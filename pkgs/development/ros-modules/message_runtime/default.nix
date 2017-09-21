{ pkgs, mkRosPackage, fetchFromGitHub }:

mkRosPackage {
  name = "message_runtime";
  version = "0.4.12";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "message_runtime-release";
    rev = "release/lunar/message_runtime/0.4.12-0";
    sha256 = "0mh60p1arv7gj0w0wgg3c4by76dg02nd5hkd4bh5g6pgchigr0qy";
  };

  propagatedBuildInputs = with pkgs;
  [ catkin genmsg gencpp genpy genlisp geneus gennodejs
    cpp_common roscpp_serialization roscpp_traits rostime ];
}
