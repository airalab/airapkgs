{ stdenv, python27, python27Packages }:

attrs:

let
  SHLIB = if stdenv.isDarwin then "dylib" else "so";

  pyEnv = with python27Packages;
    [ numpy setuptools sphinx dateutil docutils pyyaml nose rosdep rospkg
      rosdistro rosinstall-generator wstool rosinstall catkin_tools catkin_pkg
      bloom empy matplotlib pillow pydot paramiko coverage
      netifaces mock psutil pyqt4 vcstools defusedxml pygraphviz ];


  rosShellHook = pkg: ''
    if [ -d "${pkg}/env-hooks" ]; then
      for i in ''$(find "${pkg}/env-hooks" -name "*.sh"); do
        source "''$i"
      done fi
  '';

in stdenv.mkDerivation (attrs // {

#  propagatedBuildInputs = pyEnv ++ attrs.propagatedBuildInputs;

  postInstall = attrs.postInstall or ''
    pushd ..
    if [ -f 'package.xml' ]; then
      cp package.xml ''$out
    fi
    if [ -d 'resources' ]; then
      cp -r resources ''$out
    fi
    if [ -d 'images' ]; then
      cp -r images ''$out
    fi
    if [ -d 'env-hooks' ]; then
      cp -r env-hooks ''$out
    fi
    popd
  '';

  postFixup = attrs.postFixup or ''
    find "''$prefix" -type f -perm -0100 | while read f; do
      if [ "''$(head -1 "''$f" | head -c+2)" != '#!' ]; then
        # missing shebang => not a script
        continue
      fi
      sed -i 's|#!\(/nix/store/.*/python\)|#!/usr/bin/env \1|' "''$f"
    done
  '';

    #cmakeFlags = attrs.cmakeFlags or  [
    #  "-DPYTHON_LIBRARY=${pyEnv}/lib/libpython2.7.${SHLIB}"
    #  "-DPYTHON_INCLUDE_DIR=${pyEnv}/include/python2.7"
    #  "-DPYTHON_EXECUTABLE=${pyEnv}/bin/python"
    #];

    #shellHook = ''
    #export ROS_MASTER_URI="http://localhost:11311"
    #export ROS_PACKAGE_PATH=${with stdenv.lib;
    #  concatStringsSep ":" (filter builtins.isAttrs (attrValues rosPackageSet))}
    #export PYTHONPATH=${with stdenv.lib;
    #  concatMapStringsSep ":"
    #    (d: d + "/lib/python2.7/site-packages")
    #    (attrValues rosPackageSet)}
    #${with stdenv.lib;
    #  concatMapStringsSep "\n" rosShellHook (attrValues rosPackageSet)}
    #'';

})
