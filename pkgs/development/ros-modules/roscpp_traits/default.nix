{ stdenv
, mkRosPackage
, fetchFromGitHub
, catkin
, cpp_common
, rostime
}:

let
  pname = "roscpp_traits";
  version = "0.6.12";
  rosdistro = "melodic";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "roscpp_core-release";
    rev = "release/${rosdistro}/${pname}/${version}-0";
    sha256 = "01030srgf8ygn28vlhahamy87gayl4kzywfbfjppbb4zag437dmb";
  };

  propagatedBuildInputs = [ catkin cpp_common rostime ];

  meta = with stdenv.lib; {
    description = "Contains the message traits code, is a component of roscpp";
    homepage = http://wiki.ros.org/roscpp_traits;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
