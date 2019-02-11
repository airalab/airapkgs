{stdenv, fetchFromGitHub
, buildPackages
, callPackage
, pkgconfig
, libusb, readline, libewf, perl, zlib, openssl
, libuv, file, libzip, xxHash
, gtk2 ? null, vte ? null, gtkdialog ? null
, python3 ? null
, ruby ? null
, lua ? null
, useX11, rubyBindings, pythonBindings, luaBindings
}:

assert useX11 -> (gtk2 != null && vte != null && gtkdialog != null);
assert rubyBindings -> ruby != null;
assert pythonBindings -> python3 != null;


let
  inherit (stdenv.lib) optional;

  generic = {
    version_commit,
    gittap,
    gittip,
    rev,
    version,
    sha256,
    cs_tip,
    cs_sha256
  }:
    stdenv.mkDerivation rec {
      name = "radare2-${version}";

      src = fetchFromGitHub {
        owner = "radare";
        repo = "radare2";
        inherit rev sha256;
      };

      postPatch = let
        capstone = fetchFromGitHub {
          owner = "aquynh";
          repo = "capstone";
          # version from $sourceRoot/shlr/Makefile
          rev = cs_tip;
          sha256 = cs_sha256;
        };
      in ''
        if ! grep -F "CS_TIP=${cs_tip}" shlr/Makefile; then echo "CS_TIP mismatch"; exit 1; fi
        # When using meson, it expects capstone source relative to build directory
        mkdir -p build/shlr
        cp -r ${capstone} shlr/capstone
        chmod -R +w shlr/capstone
      '';

      postInstall = ''
        install -D -m755 $src/binr/r2pm/r2pm $out/bin/r2pm
      '';

      WITHOUT_PULL="1";
      makeFlags = [
        "GITTAP=${gittap}"
        "GITTIP=${gittip}"
        "RANLIB=${stdenv.cc.bintools.bintools}/bin/${stdenv.cc.bintools.targetPrefix}ranlib"
      ];
      configureFlags = [
        "--with-sysmagic"
        "--with-syszip"
        "--with-sysxxhash"
        "--with-openssl"
      ];

      enableParallelBuilding = true;
      depsBuildBuild = [ buildPackages.stdenv.cc ];

      nativeBuildInputs = [ pkgconfig ];
      buildInputs = [ file readline libusb libewf perl zlib openssl libuv ]
        ++ optional useX11 [ gtkdialog vte gtk2 ]
        ++ optional rubyBindings [ ruby ]
        ++ optional pythonBindings [ python3 ]
        ++ optional luaBindings [ lua ];

      propagatedBuildInputs = [
        # radare2 exposes r_lib which depends on these libraries
        file # for its list of magic numbers (`libmagic`)
        libzip
        xxHash
      ];

      meta = {
        description = "unix-like reverse engineering framework and commandline tools";
        homepage = http://radare.org/;
        license = stdenv.lib.licenses.gpl2Plus;
        maintainers = with stdenv.lib.maintainers; [ raskin makefu mic92 ];
        platforms = with stdenv.lib.platforms; linux;
        inherit version;
      };
  };
in {
  #<generated>
  # DO NOT EDIT! Automatically generated by ./update.py
  radare2 = generic {
    version_commit = "20591";
    gittap = "3.2.1";
    gittip = "25913f4745cb3b635d52f1aafc4d8ff2aad3988a";
    rev = "3.2.1";
    version = "3.2.1";
    sha256 = "1c4zj96386sc9lvfcsdh9lhyh0rvv4zzfr6218gvjkg9fy6cc91y";
    cs_tip = "0ff8220adef16a942697afd245afc5ab0f70cbf8";
    cs_sha256 = "1ak8ysgivq28d23r77881p0z5v65jhpap5plm10p9j3y2x00n3zn";
  };
  r2-for-cutter = generic {
    version_commit = "20591";
    gittap = "2.9.0-310-gcb62c376b";
    gittip = "cb62c376bef6c7427019a7c28910c33c364436dd";
    rev = "cb62c376bef6c7427019a7c28910c33c364436dd";
    version = "2018-10-07";
    sha256 = "0z4nr1d2ca8ibq34441j15pj22wh46brcbr00j5hcqvn8y2lh96l";
    cs_tip = "e2c1cd46c06744beaceff42dd882de3a90f0a37c";
    cs_sha256 = "1czzqj8zdjgh7h2ixi26ij3mm4bgm4xw2slin6fv73nic8yaw722";
  };
  #</generated>
}
