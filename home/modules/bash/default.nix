{config, ...}: {

  # enable bash
  programs.bash = {
    enable = true;
    initExtra = ''
      source ${config.home.homeDirectory}/.dotfiles/home/modules/bash/git-prompt.sh
      source ${config.home.homeDirectory}/.dotfiles/home/modules/bash/config.sh
    '';
  };
}
