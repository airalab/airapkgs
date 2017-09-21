{ stdenv, pythonPackages }:

with pythonPackages;

buildPythonPackage rec { 
  name = "${pname}-${version}";
  version = "0.11.8";
  pname = "rosdep";

  src = fetchPypi {
    inherit pname version;
    sha256 = "1bl7p37bc0zznx5m5sxnzgfb5d8f3ghi3wy9f8318q7q2i0yx1c1";
  };

  propagatedBuildInputs = [ catkin_pkg rospkg rosdistro pyyaml ];

  doCheck = false;

  meta = with stdenv.lib; {
    homepage = http://wiki.ros.org/rosdep;
    description = "Is a command-line tool for installing system dependencies.";
    license = licenses.bsd3;
  }; 
}
