# plasma-manager powerdevil module

{ ... }:

{
  programs.plasma.powerdevil = rec {
    AC = {
      autoSuspend = {
        action = "sleep";
        idleTimeout = 1800; # 30 mins
      };
      turnOffDisplay = {
        idleTimeout = 1500; # 25 mins
        idleTimeoutWhenLocked = 60;
      };
      dimDisplay = {
        enable = true;
        idleTimeOut = 1440; # 24 mins
      };
      powerButtonAction = "showLogoutScreen";
      whenLaptopLidClosed = "sleep";
      inhibitLidActionWhenExternalMonitorConnected = false;
    };
    battery = {
      autoSuspend = {
        action = "sleep";
        idleTimeout = 1200; # 20 mins
      };
      turnOffDisplay = {
        idleTimeout = 600; # 10 mins
        idleTimeoutWhenLocked = 60;
      };
      dimDisplay = {
        enable = true;
        idleTimeOut = 540; # 9 mins
      };
      powerButtonAction = "showLogoutScreen";
      whenLaptopLidClosed = "sleep";
      inhibitLidActionWhenExternalMonitorConnected = false;
    };
    # same config for low battery
    lowBattery = battery;
  };
}