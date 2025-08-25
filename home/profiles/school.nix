{pkgs, ...}: {
  home.packages = with pkgs; [
    globalprotect-openconnect
    quartus-prime-lite
  ];
}
