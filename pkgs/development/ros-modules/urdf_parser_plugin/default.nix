{ stdenv
, mkRosPackage
, fetchFromGitHub
, catkin
, urdfdom_headers
}:

let
  pname = "urdf_parser_plugin";
  version = "1.13.1";
  rosdistro = "melodic";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "media_export-release";
    rev = "release/${rosdistro}/${pname}/${version}-0";
    sha256 = "1ppq48zzg0gwyllznxgav3lkhyxzdfq54y99acbxhkbqfkfqcyi8";
  };

  propagatedBuildInputs = [ catkin urdfdom_headers ];

  meta = with stdenv.lib; {
    description = "Base class for URDF parsers.";
    homepage = http://wiki.ros.org/urdf_parser_plugin;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru mintainers.nschoe ];
  };
}
