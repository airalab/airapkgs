{ stdenv
, mkRosPackage
, fetchFromGitHub
, catkin
, cpp_common
}:

let
  pname = "rostime";
  version = "0.6.7";
  rosdistro = "melodic";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "roscpp_core-release";
    rev = "release/${rosdistro}/${pname}/${version}-0";
    sha256 = "10skmbdkygis1ag0mpn3215yb2fbfaqrkdkna4ypp3clnmdj9dhj";
  };

  propagatedBuildInputs = [ catkin cpp_common ];

  meta = with stdenv.lib; {
    description = "Time and Duration implementations for C++ libraries";
    homepage = http://wiki.ros.org/rostime;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
