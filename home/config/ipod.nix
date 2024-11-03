# stuff for loading music onto my ipod
{
  pkgs,
  lib,
  ...
}:
with pkgs; let
  # force python312Packages.protobuf version
  # (note: I deleted a bunch of stuff from here that broke the build but idk what they did)
  protobuf320 = with python3.pkgs;
    buildPythonPackage
    rec {
      pname = "protobuf";
      version = "3.20.3";
      pyproject = true;
      src = fetchPypi {
        inherit pname version;
        hash = "sha256-LjQnQpyc/+vyWUkb4K9wGJYH82XC9Bx8N2SvbzNxBfI=";
      };
      build-system = [setuptools];
      doCheck = false;
      pythonImportsCheck = [
        "google.protobuf"
        "google.protobuf.compiler"
        "google.protobuf.internal"
        "google.protobuf.pyext"
        "google.protobuf.util"
      ];
      meta = {
        description = "Protocol Buffers are Google's data interchange format";
        homepage = "https://developers.google.com/protocol-buffers/";
        changelog = "https://github.com/protocolbuffers/protobuf/releases/v${version}";
        license = lib.licenses.bsd3;
        maintainers = with lib.maintainers; [SuperSandro2000];
      };
    };

  # get onthespot from appimage (for version 0.7)
  onTheSpot = python3.pkgs.buildPythonApplication rec {
    pname = "onthespot";
    version = "0.7.1";
    pyproject = true;
    src = fetchFromGitHub {
      owner = "justin025";
      repo = "onthespot";
      rev = "refs/tags/v${version}";
      hash = "sha256-G4c1u7HvTap6iZ2ttGBxhRpYrdICIGXwfgo7Jbmq/R4=";
    };
    pythonRemoveDeps = [
      "PyQt6-Qt6"
      "PyQt6-stubs"
      # Doesn't seem to be used in the sources and causes build issues
      "PyOgg"
    ];
    pythonRelaxDeps = true;
    nativeBuildInputs = [
      copyDesktopItems
      qt6.wrapQtAppsHook
    ];
    dependencies = with python3.pkgs; [
      async-timeout
      charset-normalizer
      defusedxml
      ffmpeg
      (librespot.override
        {
          protobuf = protobuf320;
        })
      music-tag
      packaging
      pillow
      pyperclip
      pyqt6
      pyqt6-sip
      pyxdg
      qt6.qtbase
      requests
      setuptools
      show-in-file-manager
      urllib3
      zeroconf
    ];
    postInstall = ''
      install -Dm444 \
        $src/src/onthespot/resources/icons/onthespot.png \
        $out/share/icons/hicolor/256x256/apps/onthespot.png
    '';
    preFixup = "makeWrapperArgs+=(\"\${qtWrapperArgs[@]}\")";
    desktopItems = [
      (makeDesktopItem {
        name = "Onthespot";
        exec = "onthespot";
        icon = "onthespot";
        desktopName = "Onthespot";
        comment = meta.description;
        categories = ["Audio"];
      })
    ];
    meta = {
      description = "QT based Spotify music downloader written in Python";
      homepage = "https://github.com/casualsnek/onthespot";
      changelog = "https://github.com/casualsnek/onthespot/releases/tag/v${version}";
      license = lib.licenses.gpl2Only;
      maintainers = with lib.maintainers; [onny];
      platforms = lib.platforms.linux;
      mainProgram = "onthespot_gui";
    };
  };
in {
  home.packages = [
    (clementine.override {
      libgpod = pkgs.libgpod;
      config = {clementine.ipod = true;};
    })
    onTheSpot
  ];
}
