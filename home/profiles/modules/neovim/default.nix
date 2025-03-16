{pkgs, config, ...} : {
  # setup neovim
  programs.neovim = {
    enable = true;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    defaultEditor = true;

    plugins = with pkgs.vimPlugins; [
      # plugins are managed by lazy.nvim
      lazy-nvim
    ];

    extraPackages = with pkgs; [
      # lsp
      lua-language-server
      nixd
      zls
      pyright
      gopls
      ocamlPackages.ocaml-lsp
      clang-tools

      # tools some plugins need
      luajitPackages.luarocks
      imagemagick
      texliveSmall
      mermaid-cli
      lazygit
      ripgrep
      fd
      ghostscript
      bashInteractive
      gcc
      fzf
    ];
  };

  xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink "/home/nathan/.dotfiles/home/profiles/modules/neovim/nvim";
}
