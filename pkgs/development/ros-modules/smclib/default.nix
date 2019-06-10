{ stdenv
, mkRosPackage
, fetchFromGitHub
, catkin
}:

let
  pname = "smclib";
  version = "1.8.3";
  rosdistro = "melodic";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "bond_core-release";
    rev = "release/${rosdistro}/${pname}/${version}-0";
    sha256 = "07sy0s6vmzfgs5xyhz9mr7gy48337h89ki2p0xhf3si1bwrm3ndc";
  };

  propagatedBuildInputs = [ catkin ];

  meta = with stdenv.lib; {
    description = "The State Machine Compiler (SMC) converts a language-independent description of a state machine into the source code to support that state machine.";
    homepage = https://wiki.ros.org/smclib;
    license = licenses.bsd3;
    platforms = platforms.linux;
    maintainers = [ maintainers.akru maintainers.nschoe ];
  };
}
