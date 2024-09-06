# plasma config

{ pkgs, ... }:

{
  programs.plasma = {
    enable = true;
    overrideConfig = true;

    # setup displays on startup
    startup.startupScript."displaySetup".text = ''
      ${pkgs.kdePackages.libkscreen}/bin/kscreen-doctor \
        output.1.scale.1.3 \
        output.1.position.0,0 \
        output.2.scale.1 \
        output.2.position.-1920,0 \
    '';

    input.mice = [
      {
        acceleration = -0.2;
        accelerationProfile = "none";
        enable = true;
        name = "Razer Razer DeathAdder Essential";
        naturalScroll = false;
        productId = "006e";
        vendorId = "1532";
      }
    ];
  };
}
