{ stdenv
, mkRosPackage
, fetchFromGitHub
, catkin
}:

let
  pname = "media_export";
  version = "0.2.0";
  rosdistro = "melodic";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "media_export-release";
    rev = "release/${rosdistro}/${pname}/${version}-0";
    sha256 = "1yk6156n4mjvx8caykpzandj43wgwxma55xx91x8l94byk6w9jqx";
  };

propagatedBuildInputs = [ catkin ];

  meta = with stdenv.lib; {
    description = "Placeholder package enabling generic export of media paths.";
    homepage = http://wiki.ros.org/media_export;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru mintainers.nschoe ];
  };
}
