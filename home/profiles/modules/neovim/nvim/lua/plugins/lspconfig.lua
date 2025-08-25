return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'saghen/blink.cmp',
    {
      -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
      -- used for completion, annotations and signatures of Neovim apis
      'folke/lazydev.nvim',
      ft = 'lua',
      opts = {
        library = {
          -- Load luvit types when the `vim.uv` word is found
          { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
        },
      },
    },
  },

  -- example using `opts` for defining servers
  opts = {
    servers = {
      lua_ls = {},
      nixd = {},
      zls = {},
      pyright = {},
      gopls = {},
      ocamllsp = {},
      svelte = {},
      clangd = {},

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
  },

  config = function(_, opts)
    local lspconfig = require('lspconfig')
    for server, config in pairs(opts.servers) do
      -- passing config.capabilities to blink.cmp merges with the capabilities in your
      -- `opts[server].capabilities, if you've defined it
      config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
      lspconfig[server].setup(config)
    end

    -- configure keymaps
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename)
  end
}
