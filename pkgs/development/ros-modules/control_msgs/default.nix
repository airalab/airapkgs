{ stdenv
, mkRosPackage
, fetchFromGitHub
, actionlib_msgs
, trajectory_msgs
, geometry_msgs
, message_generation
, message_runtime
}:

mkRosPackage rec {
  name = "${pname}-${version}";
  pname = "control_msgs";
  version = "1.5.0";
  rosdistro = "melodic";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "conrol_msgs-release";
    rev = "release/${rosdistro}/${pname}/${version}-0";
    sha256 = "0vff4yryxcww8x5f1s3pkl0ccw2l0i7a7wv22fdp1vinqyazjrs9";
  };

  propagatedBuildInputs = [ message_generation message_runtime actionlib_msgs geometry_msgs trajectory_msgs ];

  meta = with stdenv.lib; {
    description = "Base messages and actions useful for controlling robots. It provides representations for controller setpoints and joint and cartesian trajectories.";
    homepage = http://wiki.ros.org/control_msgs;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru maintainers.nschoe ];
  };
}
