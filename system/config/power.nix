# power/sleep options
{...}: {
  services.logind.lidSwitch = "hibernate";
  services.logind.powerKey = "ignore";
}
