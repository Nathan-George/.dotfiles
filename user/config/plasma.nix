# plasma config

{ ... }:

{
  programs.plasma = {
    enable = true;
    overrideConfig = true;

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
