# google chrome config

{ config, lib, pkgs, ... }:

let
  chromeMimeTypes = [
    "application/pdf" "application/rdf+xml" "application/rss+xml" "application/xhtml+xml" "application/xhtml_xml" "application/xml"
    "image/gif" "image/jpeg" "image/png" "image/webp" "text/html" "text/xml" "x-scheme-handler/http" "x-scheme-handler/https"
  ];
in {
  # make sure package is installed
  home.packages = [ pkgs.google-chrome ];

  # override desktop entry (bc of wayland/ozone issues)
  xdg.desktopEntries."google-chrome" = {
    name = "Google Chrome";
    genericName = "Web Browser";
    comment = "Access the Internet";
    exec = "${pkgs.google-chrome}/bin/google-chrome-stable --ozone-platform=wayland %U";
    icon = "google-chrome";
    categories = [ "Network" "WebBrowser" ];
    mimeType = chromeMimeTypes;
    actions = {
      "new-window" = {
        name = "New Window";
        exec = "${pkgs.google-chrome}/bin/google-chrome-stable --ozone-platform=wayland";
      };
      "new-private-window" = {
        name = "New Incognito Window";
        exec = "${pkgs.google-chrome}/bin/google-chrome-stable --ozone-platform=wayland --incognito";
      };
    };
  };
  
  # make chrome default for supported mime types
  xdg.mimeApps = {
    enable = true;
    defaultApplications = builtins.listToAttrs (
      builtins.map (type:{name=type;value="google-chrome.desktop";}) chromeMimeTypes
    );
  };

}