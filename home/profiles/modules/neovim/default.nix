{pkgs, lib, ...} : {
  # setup neovim
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    extraLuaConfig = "./init.lua";

    plugins = with pkgs.vimPlugins; [
      gitsigns-nvim
      nvim-cmp
      nvim-lspconfig
      nvim-treesitter.withAllGrammars
      telescope-nvim
      vim-sleuth
      which-key-nvim
    ];
  };
}
