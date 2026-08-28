# git config
{...}: {
  programs.git = {
    enable = true;
    settings = {
      user.name = "Nathan George";
      user.email = "nbg0520@gmail.com";
      format.pretty = "oneline";
      log.abbrevCommit = true;
      pull.rebase = true;
    };
  };
}
