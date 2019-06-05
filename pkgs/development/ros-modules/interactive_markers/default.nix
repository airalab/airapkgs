{ stdenv
, mkRosPackage
, fetchFromGitHub
, catkin
, rosconsole
, roscpp
, rospy
, rostest
, std_msgs
, tf
, visualization_msgs
}:

let
  pname = "interactive_markers";
  version = "1.11.4";
  rosdistro = "melodic";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "${pname}-release";
    rev = "release/${rosdistro}/${pname}/${version}-0";
    sha256 = "19l1vgzxzrizn6djabh2h6ix8ivrxzj93lsc5873yas9d8qngggs";
  };

  propagatedBuildInputs = [ catkin rosconsole roscpp rospy rostest std_msgs tf visualization_msgs ];

  meta = with stdenv.lib; {
    description = "3D interactive marker communication library for RViz and similar tools.";
    homepage = http://wiki.ros.org/interactive_markers;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru maintainers.nschoe ];
  };
}
