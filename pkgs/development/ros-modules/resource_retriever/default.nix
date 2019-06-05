{ stdenv
, mkRosPackage
, fetchFromGitHub
, catkin
, rosconsole
, roslib
}:

let
  pname = "resource_retriever";
  version = "1.12.4";
  rosdistro = "melodic";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "media_export-release";
    rev = "release/${rosdistro}/${pname}/${version}-0";
    sha256 = "0ppp8m3s0xx72ffgpj5ym9xflcj7dcbv8afz2690ky51g6npmqv5";
  };

propagatedBuildInputs = [ catkin rosconsole roslib ];

  meta = with stdenv.lib; {
    description = "Retrieves data from url-format files such as http://, ftp://, package:// file://, etc., and loads the data into memory.";
    homepage = http://wiki.ros.org/resource_retriever;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru mintainers.nschoe ];
  };
}
