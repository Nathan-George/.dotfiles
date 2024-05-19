# qimgv config

{ config, lib, pkgs, ... }:

let
  desktopEntry = pkgs.mkDesktopItem {
    name = "qimgv";
    desktopName = "qimgv";
    exec = "qimgv";
  };
  imageMimeTypes = [ "jpeg" "png" "gif" ];
in {

  # install package
  home.packages = [ pkgs.qimgv ];

  # make qimgv the default image editor
  xdg.mimeApps = {
    enable = true;
    defaultApplications = builtins.listToAttrs ( builtins.map (type:{name="image/${type}";value="qimgv.desktop";}) imageMimeTypes );
  };

  # settings
  xdg.configFile."qimgv/qimgv.conf".text = ''
    [General]
    JPEGSaveQuality=95
    absoluteZoomStep=false
    autoResizeLimit=80
    autoResizeWindow=true
    backgroundOpacity=1
    blurBackground=false
    confirmDelete=true
    confirmTrash=true
    cursorAutohiding=true
    defaultCropAction=0
    defaultFitMode=1
    defaultViewMode=0
    drawTransparencyGrid=false
    enableSmoothScroll=true
    expandImage=true
    expandLimit=4
    firstRun=false
    focusPointIn1to1Mode=1
    folderEndAction=0
    imageScrolling=1
    infoBarFullscreen=true
    infoBarWindowed=true
    jxlAnimation=false
    keepFitMode=true
    lastVerMajor=1
    lastVerMicro=2
    lastVerMinor=0
    loopSlideshow=false
    mpvBinary=/nix/store/0nsfihd465gsqcwcpfxqdbpi74wjcll1-mpv-with-scripts-0.36.0/bin/mpv
    openInFullscreen=false
    panelEnabled=false
    panelFullscreenOnly=false
    panelPosition=top
    panelPreviewsSize=140
    playVideoSounds=false
    scalingFilter=1
    showSaveOverlay=true
    slideshowInterval=3000
    smoothAnimatedImages=true
    smoothUpscaling=true
    sortingMode=1
    squareThumbnails=false
    thumbPanelStyle=1
    thumbnailCache=true
    thumbnailerThreads=4
    unloadThumbs=true
    useOpenGL=false
    usePreloader=true
    useSystemColorScheme=false
    videoPlayback=false
    windowTitleExtendedInfo=false
    zoomIndicatorMode=0
    zoomStep=0.20000000298023224

    [Controls]
    shortcuts="zoomIn=Ctrl+", "zoomOut=Ctrl+-", "print=Ctrl+P", "save=Ctrl+S", "saveAs=Ctrl+Shift+S", "closeFullScreenOrExit=Esc", "toggleFullscreen=F11", "renameFile=F2", "prevImage=Left", "contextMenu=RMB", "nextImage=Right", "zoomOutCursor=WheelDown", "zoomInCursor=WheelUp"

    [Scripts]
    script\size=0
  '';

  # theme
  xdg.configFile."qimgv/theme.conf".text = ''
    [Colors]
    accent=#336ca5
    background=#18191a
    background_fullscreen=#18191a
    folderview=#232629
    folderview_topbar=#31363b
    icons=#babec3
    overlay=#1a1a1a
    overlay_text=#d2d2d2
    scrollbar=#4f565c
    text=#cdd2d7
    widget=#232629
    widget_border=#26292d
  '';
}
