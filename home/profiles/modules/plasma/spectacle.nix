# plasma-manager spectacle module
{...}: {
  programs.plasma.spectacle = {
    shortcuts = {
      captureActiveWindow = "";
      captureCurrentMonitor = "";
      captureEntireDesktop = "";
      captureRectangularRegion = "Print";
      captureWindowUnderCursor = "";
      launch = "";
      launchWithoutCapturing = "";
      recordRegion = "";
      recordScreen = "";
      recordWindow = "";
    };
  };
}
