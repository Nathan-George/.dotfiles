# power/sleep options
{...}: {
  boot.kernelParams = ["resume_offset=143177728"];
  boot.resumeDevice = "/dev/disk/by-uuid/63e2fe76-b072-4fc0-b1ac-55be22d8c3e4";

  powerManagement.enable = true;

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 16 * 1024;
    }
  ];
  services.logind.lidSwitch = "hibernate";
  services.logind.powerKey = "ignore";
}
