{ stdenv
, mkRosPackage
, fetchFromGitHub
, catkin
, message_generation
, std_msgs
}:

let
  pname = "bond";
  version = "1.8.3";
  rosdistro = "melodic";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "bond_core-release";
    rev = "release/${rosdistro}/${pname}/${version}-0";
    sha256 = "0d3y30r7kb8k4bqdr8s8b581ad8h19f9i99js807jpx8ddkd0gk4";
  };

  propagatedBuildInputs = [ catkin message_generation std_msgs ];

  meta = with stdenv.lib; {
    description = "A bond allows two processes, A and B, to know when the other has terminated, either cleanly or by crashing. The bond remains connected until it is either broken explicitly or until a heartbeat times out.";
    homepage = https://wiki.ros.org/bond;
    license = licenses.bsd3;
    platforms = platforms.linux;
    maintainers = [ maintainers.akru maintainers.nschoe ];
  };
}
