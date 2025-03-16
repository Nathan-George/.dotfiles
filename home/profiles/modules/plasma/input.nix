# plasma-manager input module
{...}: {
  programs.plasma.input = let
    # for consistent touchpad config between 'mice' and 'touchpads' options
    touchpad = rec {
      acceleration = pointerSpeed;
      accelerationProfile = "none";
      disableWhileTyping = true;
      enable = true;
      name = "PIXA3854:00 093A:0274 Touchpad";
      naturalScroll = true;
      pointerSpeed = 1.0;
      productId = "0274";
      rightClickMethod = "twoFingers";
      scrollMethod = "twoFingers";
      scrollSpeed = 0.2;
      tapAndDrag = true;
      tapToClick = true;
      twoFingerTap = "rightClick";
      vendorId = "093a";
    };
  in {
    # TODO: add my mouse
    mice = [
      {
        acceleration = -0.2;
        accelerationProfile = "none";
        enable = true;
        name = "Razer Razer DeathAdder Essential";
        naturalScroll = false;
        productId = "006e";
        vendorId = "1532";
      }
      # {
      #   inherit
      #     (touchpad)
      #     acceleration
      #     accelerationProfile
      #     enable
      #     name
      #     naturalScroll
      #     productId
      #     scrollSpeed
      #     vendorId
      #     ;
      # }
    ];
    touchpads = [
      {
        inherit
          (touchpad)
          disableWhileTyping
          enable
          name
          naturalScroll
          pointerSpeed
          productId
          rightClickMethod
          scrollMethod
          tapAndDrag
          tapToClick
          twoFingerTap
          vendorId
          ;
      }
    ];
  };
}
