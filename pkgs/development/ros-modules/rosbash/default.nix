{ stdenv
, mkRosPackage
, fetchFromGitHub
, catkin
}:

let
  pname = "rosbash";
  version = "1.14.6";
  rosdistro = "melodic";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "ros-release";
    rev = "release/${rosdistro}/${pname}/${version}-0";
    sha256 = "1dbbvhdaq6ab7qmalambdvscl11sbn9n127imcn31iilc0n0w9zx";
  };

  propagatedBuildInputs = [ catkin ];

  patchPhase = ''
    sed -i 's|_perm="+111"|_perm="/111"|' ./scripts/rosrun
  '';

  meta = with stdenv.lib; {
    description = "Assorted shell commands for using ros with bash";
    homepage = http://wiki.ros.org/rosbash;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
