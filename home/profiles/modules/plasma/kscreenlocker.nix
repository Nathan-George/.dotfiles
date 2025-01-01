# plasma-manager kscreenlocker module
{config, ...}: {
  programs.plasma.kscreenlocker = {
    lockOnResume = true;
    lockOnStartup = false;
    autoLock = false;

    passwordRequired = true;
    passwordRequiredDelay = 60;

    appearance = {
      alwaysShowClock = true;
      showMediaControls = false;
      wallpaper = config.programs.plasma.workspace.wallpaper;
    };
  };
}
