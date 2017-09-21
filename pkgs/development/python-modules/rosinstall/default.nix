{ stdenv, pythonPackages }:

with pythonPackages;

buildPythonPackage rec { 
  name = "${pname}-${version}";
  version = "0.7.8";
  pname = "rosinstall";

  src = fetchPypi {
    inherit pname version;
    sha256 = "0h7d8ynv44c68sbfn28xw4k18k3ip6252x7r7bqw6b5cifzhia1b";
  };

  propagatedBuildInputs = [ vcstools pyyaml rosdistro catkin_pkg wstool rospkg ];

  doCheck = false;

  meta = with stdenv.lib; {
    homepage = http://wiki.ros.org/rosinstall;
    description = "rosinstall is based on the vcstools library, which does all of the SCM related work.";
    license = licenses.bsd3;
  }; 
}
