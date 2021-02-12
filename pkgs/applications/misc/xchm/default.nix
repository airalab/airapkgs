{ lib, stdenv, fetchFromGitHub, autoreconfHook, wxGTK30, chmlib }:

stdenv.mkDerivation rec {
  pname = "xchm";
  version = "1.31";

  src = fetchFromGitHub {
    owner = "rzvncj";
    repo = "xCHM";
    rev = version;
    sha256 = "1mzafbpc1c211byf8bnwl13by7vi8xvxlaykyrajb1bj0ynbmmgp";
  };

  nativeBuildInputs = [ autoreconfHook ];
  buildInputs = [ wxGTK30 chmlib ];

  configureFlags = [ "--with-wx-prefix=${wxGTK30}" ];

  preConfigure = ''
    export LDFLAGS="$LDFLAGS $(${wxGTK30}/bin/wx-config --libs | sed -e s@-pthread@@) -lwx_gtk2u_aui-3.0"
  '';

  meta = with lib; {
    description = "A viewer for Microsoft HTML Help files";
    homepage = "https://github.com/rzvncj/xCHM";
    license = licenses.gpl2;
    maintainers = with maintainers; [ sikmir ];
    platforms = platforms.linux;
  };
}
