{ stdenv
, fetchzip
, fetchFromGitHub
, llvm
, boost
, cmake
, z3
}:

let
  version = "0.4.25";
  rev = "a1ed068eca2b33acfece1f69afcb0d45133a08a5";
  sha256 = "0afcrr7q9qcl3f4qfwyx8463vlsngbwi2zv5hdsdrsxnw1d40148";
  jsoncppURL = https://github.com/open-source-parsers/jsoncpp/archive/1.8.4.tar.gz;
  jsoncpp = fetchzip {
    url = jsoncppURL;
    sha256 = "1z0gj7a6jypkijmpknis04qybs1hkd04d1arr3gy89lnxmp6qzlm";
  };
in
stdenv.mkDerivation {
  name = "isolc-${version}";

  src = fetchFromGitHub {
    owner = "runtimeverification";
    repo = "solidity";
    inherit rev sha256;
  };

  #  patches = [
  #    ./patches/shared-libs-install.patch
  #  ];

  postPatch = ''
    touch prerelease.txt
    echo >commit_hash.txt "${rev}"
    substituteInPlace cmake/jsoncpp.cmake \
      --replace "${jsoncppURL}" ${jsoncpp}

    # To allow non-standard CMAKE_INSTALL_LIBDIR (fixed in upstream, not yet released)
    substituteInPlace cmake/jsoncpp.cmake \
      --replace "\''${CMAKE_INSTALL_LIBDIR}" "lib" \
      --replace "# Build static lib but suitable to be included in a shared lib." "-DCMAKE_INSTALL_LIBDIR=lib"
  '';

  cmakeFlags = [
    "-DBoost_USE_STATIC_LIBS=OFF"
    "-DBUILD_SHARED_LIBS=ON"
    "-DINSTALL_LLLC=ON"
  ];

  doCheck = stdenv.hostPlatform.isLinux && stdenv.hostPlatform == stdenv.buildPlatform;
  checkPhase = "LD_LIBRARY_PATH=./libsolc:./libsolidity:./liblll:./libevmasm:./libdevcore:$LD_LIBRARY_PATH " +
               "./test/soltest -p -- --no-ipc --no-smt --testpath ../test";

  nativeBuildInputs = [ cmake ];
  buildInputs = [ llvm boost z3 ];

  outputs = [ "out" "dev" ];

  meta = with stdenv.lib; {
    description = "Compiler for Ethereum smart contract language Solidity";
    longDescription = "This package also includes `lllc', the LLL compiler.";
    homepage = https://github.com/ethereum/solidity;
    license = licenses.gpl3;
    platforms = with platforms; linux ++ darwin;
    maintainers = with maintainers; [ dbrock akru ];
    inherit version;
  };
}
