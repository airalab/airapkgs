{ stdenv, pythonPackages }:

with pythonPackages;

buildPythonApplication rec { 
  name = "${pname}-${version}";
  version = "3.3.2";
  pname = "empy";

  src = fetchPypi {
    inherit pname version;
    sha256 = "177avx6iv9sq2j2iak2il5lxqq0k4np7mpv5gasqmi3h4ypidw4r";
  };

  propagatedBuildInputs = [ ];

  doCheck = false;

  meta = with stdenv.lib; {
    homepage = http://www.alcyone.com/software/empy/;
    description = "A powerful and robust templating system for Python.";
    license = licenses.lgpl3;
  }; 
}
