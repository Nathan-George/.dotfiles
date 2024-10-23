# script to launch plasma logout prompt
{pkgs, ...}: {
  scripts.logoutPrompt = pkgs.writeShellScript "logout_prompt" ''
    qdbus org.kde.LogoutPrompt /LogoutPrompt promptAll
  '';
}
