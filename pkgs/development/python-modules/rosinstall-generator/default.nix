{ stdenv, pythonPackages }:

with pythonPackages;

buildPythonPackage rec { 
  name = "${pname}-${version}";
  version = "0.1.13";
  pname = "rosinstall-generator";

  src = fetchPypi {
    inherit pname version;
    sha256 = "16nyijzrq8y6xk2ph5niylc72ry8zs7swxf8qicblx6fnfi7wv05";
  };

  propagatedBuildInputs = [ argparse catkin_pkg rosdistro rospkg pyyaml ];

  doCheck = false;

  meta = with stdenv.lib; {
    homepage = http://wiki.ros.org/rosinstall_generator;
    description = "Generates rosinstall files containing information about repositories with ROS packages/stacks.";
    license = licenses.bsd3;
  }; 
}
