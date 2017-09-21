{ stdenv, pythonPackages }:

with pythonPackages;

buildPythonPackage rec { 
  name = "${pname}-${version}";
  version = "0.6.2";
  pname = "rosdistro";

  src = fetchPypi {
    inherit pname version;
    sha256 = "0y5iiyczmww9d522pva26iifiyw1p6rxv6dhh0qb4rcl87kpciw3";
  };

  propagatedBuildInputs = [ pyyaml catkin_pkg rospkg ];

  doCheck = false;

  meta = with stdenv.lib; {
    homepage = https://github.com/ros-infrastructure/rosdistro;
    description = "Tools to work with catkinized rosdistro files.";
    license = licenses.bsd3;
  }; 
}
