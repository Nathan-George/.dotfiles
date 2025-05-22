return {
  "pmizio/typescript-tools.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  opts = {},

  config = function()
    require("typescript-tools").setup({
      filetypes = {
        "javascript",
        "typescript",
        "vue",
      },
      settings = {
        tsserver_plugins = {
          "@vue/typescript-plugin",
        },
        separate_diagnostic_server = true,
        publish_diagnostic_on = "insert_leave",
      },
    })
  end,
}
