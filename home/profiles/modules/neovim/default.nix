{
  pkgs,
  config,
  ...
}: {
  # setup neovim
  programs.neovim = {
    enable = true;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    defaultEditor = true;

    plugins = with pkgs.vimPlugins; [
      lazy-nvim
      nvim-treesitter.withAllGrammars
      telescope-nvim
      nvim-lspconfig
    ];

    extraPackages = with pkgs; [
      tree-sitter

      # lsp
      lua-language-server
      nixd
      zls
      pyright
      gopls
      ocamlPackages.ocaml-lsp
      clang-tools
      harper
      vue-language-server
      svelte-language-server

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
  };

  xdg.configFile."nvim".source =
    config.lib.file.mkOutOfStoreSymlink
    "/home/nathan/.dotfiles/home/profiles/modules/neovim/nvim";

  # We cannot generate any files in `.config/nvim` because that is a symlink so we use `.config/nvim.nix` instead
  xdg.configFile."nvim.nix/init.lua".text = let
    grammarsPath = pkgs.symlinkJoin {
      name = "nvim-treesitter-grammars";
      paths = pkgs.vimPlugins.nvim-treesitter.withAllGrammars.dependencies;
    };
  in
    with pkgs.vimPlugins; ''
      -- set if neovim is running on nixos
      vim.g.nixos = true

      -- list of all plugins
      vim.g.plugin_paths = {
        ["${nvim-treesitter.pname}"] = "${nvim-treesitter}",
        ["${telescope-nvim.pname}"] = "${telescope-nvim}",
        ["${nvim-lspconfig.pname}"] = "${nvim-lspconfig}",
      }

      -- needed to add back the grammars to the run time path (rtp)
      vim.g.treesitter_grammars_path = "${grammarsPath}"
    '';
}
