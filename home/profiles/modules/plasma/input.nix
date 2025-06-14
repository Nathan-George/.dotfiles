# plasma-manager input module
{...}: {
  programs.plasma.input = {
    mice = [
      {
        enable = true;
        name = "Logitech G305";
        productId = "4074";
        vendorId = "046d";
      }
    ];
    touchpads = [
      {
        enable = true;
        name = "PIXA3854:00 093A:0274 Touchpad";
        productId = "0274";
        vendorId = "093a";

        pointerSpeed = 0.6;
        scrollSpeed = 0.4;
        tapAndDrag = true;
        tapToClick = true;
        naturalScroll = true;
        disableWhileTyping = true;
        rightClickMethod = "twoFingers";
        scrollMethod = "twoFingers";
        twoFingerTap = "rightClick";
      }
    ];
  };
}
