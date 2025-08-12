# mako config
{config, ...}: {
  services.mako = {
    enable = true;
    settings = {
      default-timeout = 3000;
    };

    extraConfig = with config.colorScheme.palette; ''
      background-color=#${base00}
      border-color=#${base07}
      text-color=#${base07}
    '';
  };

  # start on boot
  programs.plasma.startup.startupScript."mako" = {
    runAlways = true;
    text = "mako &";
  };
}
