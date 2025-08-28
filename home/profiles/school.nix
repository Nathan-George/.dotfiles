{pkgs, ...}: {
  home.packages = with pkgs; [
    globalprotect-openconnect
    quartus-prime-lite
  ];

  home.sessionVariables = {
    LM_LICENSE_FILE = "/home/nathan/.dotfiles/home/profiles/LR-247745_License.dat";
  };
}
