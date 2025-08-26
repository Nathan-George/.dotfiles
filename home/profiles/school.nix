{pkgs, ...}: {
  home.packages = with pkgs; [
    globalprotect-openconnect
    quartus-prime-lite
  ];

  home.sessionSearchVariables = let
    quartus-license-file = ./LR-247745_License.dat;
  in {
    LM_LICENSE_FILE = [
      quartus-license-file
    ];
  };
}
