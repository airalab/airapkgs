{ lib
, mkDerivation
, fetchFromGitHub
, cmake
, inotify-tools
, libcloudproviders
, libsecret
, openssl
, pcre
, pkgconfig
, qtbase
, qtkeychain
, qttools
, qtwebengine
, sqlite
}:

mkDerivation rec {
  pname = "nextcloud-client";
  version = "2.6.3";

  src = fetchFromGitHub {
    owner = "nextcloud";
    repo = "desktop";
    rev = "v${version}";
    sha256 = "17w1bx305w656jkiv55lwncxwdly8rf2dsisqw3c9bc7vz19l6p8";
  };

  patches = [
    ./0001-Explicitly-copy-dbus-files-into-the-store-dir.patch
  ];

  nativeBuildInputs = [
    pkgconfig
    cmake
  ];

  buildInputs = [
    inotify-tools
    libcloudproviders
    openssl
    pcre
    qtbase
    qtkeychain
    qttools
    qtwebengine
    sqlite
  ];

  qtWrapperArgs = [
    "--prefix LD_LIBRARY_PATH : ${lib.makeLibraryPath [ libsecret ]}"
  ];

  cmakeFlags = [
    "-DCMAKE_INSTALL_LIBDIR=lib" # expected to be prefix-relative by build code setting RPATH
    "-DNO_SHIBBOLETH=1" # allows to compile without qtwebkit
  ];

  meta = with lib; {
    description = "Nextcloud themed desktop client";
    homepage = https://nextcloud.com;
    license = licenses.gpl2;
    maintainers = with maintainers; [ caugner ma27 ];
    platforms = platforms.linux;
  };
}
