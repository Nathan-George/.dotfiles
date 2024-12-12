# sddm config
{...}: {
  services.displayManager = {
    sddm.enable = true;
    defaultSession = "plasma";
  };
}
