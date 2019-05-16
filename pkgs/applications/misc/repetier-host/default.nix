{ fetchurl, gtk2, mono, stdenv }:

stdenv.mkDerivation rec {
  name = "repetier-host-${version}";
  version = "2.1.3";

  src = fetchurl {
    url = "http://download.repetier.com/files/host/linux/repetierHostLinux_2_1_3.tgz";
    sha256 = "1wrf9yr3r57j0lb1lc36rm5n86nzyr7wqlkzix5d746c0m36chfy";
  };

  buildPhase = ''
    runHook preBuild
    frontend=$NIX_BUILD_TOP/repetier-host
    set_baudrate=$NIX_BUILD_TOP/SetBaudrate
    instdir=$out/lib/repetier-host
    echo "#!${stdenv.shell}" > $frontend
    echo "cd $instdir" >> $frontend
    echo 'export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${gtk2}/lib' >> $frontend
    echo "${mono}/bin/mono $instdir/RepetierHost.exe -home $instdir" >> $frontend
    g++ -O2 SetBaudrate.cpp -o $set_baudrate
    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall
    install -D -m 0755 $frontend $out/bin/repetier-host
    install -D -m 0755 $set_baudrate $instdir/SetBaudrate
    for file in *.{application,dll,exe,exe.config,exe.manifest}; do
      install -D -m 0644 $file $instdir/$file
    done
    for dir in data plugins; do
      cp -R $dir $instdir/$dir
    done
    for file in changelog.txt README.txt Repetier-Host-licence.txt; do
      install -D -m 0644 $file $out/share/doc/repetier-host/$file
    done
    # TODO: createDesktopIcon.sh Repetier-Host.desktop Repetier-Host.menu RepetierHostMimeTypes.xml repetier-RepetierHost.desktop
    runHook postInstall
  '';

  meta = with stdenv.lib; {
    description = "Repetier-Host is a 3D printing application developed by Hot-World GmbH & Co. KG.";
    longDescription = ''
      Some 3D printing software is easier to learn than others.
      Repetier-Host is one of the tougher ones to get familiar with, and can sometimes 
      discourage people from operating their printers.
    '';
    homepage = https://www.repetier.com/;
    license = licenses.agpl2;   
    platforms = platforms.linux;   
    maintainers = with maintainers; [ spd ];
  };

}
