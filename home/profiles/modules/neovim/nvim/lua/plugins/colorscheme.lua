return {
  -- Install Tokyonight
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd[[colorscheme tokyonight-moon]]
    end
  },

  -- Install Rose-Pine
  {
    "rose-pine/neovim",
    name = "rose-pine",
    priority = 1000,
  },

  -- Install Oxocarbon
  {
    "nyoom-engineering/oxocarbon.nvim",
    priority = 1000,
  },
}
