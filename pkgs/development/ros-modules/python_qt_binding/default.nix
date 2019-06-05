{ stdenv
, mkRosPackage
, fetchFromGitHub
, python3Packages
, ensureNewerSourcesForZipFilesHook
, catkin
, rosbuild
}:

let
  pname = "python_qt_binding";
  version = "0.3.5";
  rosdistro = "melodic";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "python_qt_binding-release";
    rev = "release/${rosdistro}/${pname}/${version}-0";
    sha256 = "0bpp1j33vc518sx7a9j2dkjidj96w711dawkw095h4qhrwr27bnh";
  };

  nativeBuildInputs = [ ensureNewerSourcesForZipFilesHook ];

  propagatedBuildInputs = [ catkin rosbuild ];

  meta = with stdenv.lib; {
    description = "Provides Python bindings for Qt.";
    homepage = http://wiki.ros.org/python_qt_binding;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru mintainers.nschoe ];
  };
}
