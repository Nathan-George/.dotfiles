# git config
{...}: {
  programs.git = {
    enable = true;
    userName = "Nathan George";
    userEmail = "nbg0520@gmail.com";
    extraConfig = {
      format.pretty = "oneline";
      log.abbrevCommit = true;
      pull.rebase = true;
    };
  };
}
