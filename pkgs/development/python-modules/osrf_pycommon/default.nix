{ stdenv, pythonPackages }:

with pythonPackages;

buildPythonPackage rec { 
  name = "${pname}-${version}";
  version = "0.1.3";
  pname = "osrf_pycommon";

  src = fetchPypi {
    inherit pname version;
    sha256 = "0da3836raprxj4kpn45pm5ardd8kcba087w2xk43jf489q72ci2i";
  };

  propagatedBuildInputs = [ trollius futures ];

  doCheck = false;

  meta = with stdenv.lib; {
    homepage = http://osrf-pycommon.readthedocs.io;
    description = "Commonly needed Python modules, used by Python software developed at OSRF.";
    license = licenses.apache2;
  }; 
}
