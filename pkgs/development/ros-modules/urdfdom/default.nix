{ stdenv
, mkRosPackage
, fetchFromGitHub
, catkin
, cmake
}:

let
  pname = "urdfdom";
  version = "0.3.0";
  rosdistro = "indigo";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "urdfdom-release";
    rev = "release/${rosdistro}/${pname}/${version}-2";
    sha256 = "17qrqzadgx2911ff3dsgcjzjgbrmjincnmk4m9n144kxhq12sf7b";
  };

propagatedBuildInputs = [ catkin ];

  meta = with stdenv.lib; {
    description = "A temporary pass through to the urdfdom rosdep";
    homepage = http://wiki.ros.org/urdfdom;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru mintainers.nschoe ];
  };
}
