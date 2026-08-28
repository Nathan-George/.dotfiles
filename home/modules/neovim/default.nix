{
  pkgs,
  config,
  ...
}: {
  # setup neovim
  programs.neovim = {
    enable = true;
    defaultEditor = true;

    plugins = with pkgs.vimPlugins; [
      nvim-treesitter.withAllGrammars
      nvim-lspconfig
      blink-cmp
      telescope-nvim
    ];

    extraPackages = with pkgs; [
      tree-sitter

      # lsp
      lua-language-server
      nil
      zls
      pyright
      gopls
      ocamlPackages.ocaml-lsp
      ocamlformat
      clang-tools
      harper
      tinymist

      # tools some plugins need
      inotify-tools
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
      nodejs_22
      typescript
    ];

    initLua = ''
      vim.g.mapleader = " "

      vim.cmd [[colorscheme catppuccin]]

      require("config.options")
      require("config.keymaps")
      require("plugins.lsp")
      require("plugins.cmp")
      require("plugins.telescope")
    '';

    withRuby = false;
    withPython3 = false;
  };

  home.file.".config/nvim/lua".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/home/modules/neovim/lua";
}
