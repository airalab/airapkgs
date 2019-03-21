{ stdenv
, mkRosPackage
, fetchFromGitHub
, catkin
}:

let
  pname = "roscreate";
  version = "1.14.6";
  rosdistro = "melodic";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "ros-release";
    rev = "release/${rosdistro}/${pname}/${version}-0";
    sha256 = "1d8w7wjkgc00n1dy0c0scbq26p7zlj8amqjhq4574nqavvq1n0i3";
  };

  propagatedBuildInputs = [ catkin ];

  meta = with stdenv.lib; {
    description = "";
    homepage = http://wiki.ros.org/roscreate;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
