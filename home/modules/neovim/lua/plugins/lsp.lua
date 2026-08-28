vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename)

local servers = {
  lua_ls = {
    settings = {
      Lua = {
        diagnostics = {
          -- Tell the language server to recognize the `vim` global
          globals = { "vim" },
        },
        workspace = {
          -- Make the server aware of Neovim runtime files for autocompletion
          library = vim.api.nvim_get_runtime_file("", true),
          -- Stop the annoying "Do you need to configure your work environment..." prompt
          -- checkThirdParty = false,
        },
        telemetry = {
          enable = false,
        },
      },
    },
  },
  nil_ls = {},
  zls = {},
  pyright = {},
  gopls = {},
  ocamllsp = {},
  svelte = {},
  clangd = {},
  tinymist = {},
  harper_ls = {
    settings = {
      ["harper-ls"] = {
        userDictPath = "",
        fileDictPath = "",
        linters = {
          SpellCheck = true,
          SentenceCapitalization = false,
        },
        codeActions = {
          ForceStable = false
        },
        markdown = {
          IgnoreLinkTitle = false
        },
        diagnosticSeverity = "hint",
        isolateEnglish = false,
        dialect = "American"
      }
    }
  },
}

local capabilities = require('blink.cmp').get_lsp_capabilities()

for server, config in pairs(servers) do
  config.capabilities = capabilities
  vim.lsp.config(server, config)
  vim.lsp.enable(server)
end
