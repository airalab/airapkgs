{ pkgs, mkRosPackage, fetchFromGitHub }:

mkRosPackage {
  name = "roscreate";
  version = "1.14.1";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "ros-release";
    rev = "release/lunar/roscreate/1.14.1-0";
    sha256 = "05yp740l58mw3dlaw09668avlr0i992j0i0bfcbvd8hll3imbg0n";
  };

  propagatedBuildInputs = with pkgs; [ catkin ];
}
