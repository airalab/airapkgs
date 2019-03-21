{ stdenv
, mkRosPackage
, fetchFromGitHub
, catkin
}:

let
  pname = "rosboost_cfg";
  version = "1.14.6";
  rosdistro = "melodic";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "ros-release";
    rev = "release/${rosdistro}/${pname}/${version}-0";
    sha256 = "1d92nzcdvhfzmxgv9c02v1yjjxa7ds1k39j537x7lbw84wyf23g9";
  };

  propagatedBuildInputs = [ catkin ];

  meta = with stdenv.lib; {
    description = "Contains scripts used by the rosboost-cfg tool for determining cflags/lflags/etc. of boost on your system";
    homepage = http://wiki.ros.org/rosboost_cfg;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
