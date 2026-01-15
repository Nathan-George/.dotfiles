-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")

vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")

-- Typst editing mode
vim.keymap.set("n", "<M-w>", function()
  vim.o.background = "light"
  vim.cmd[[colorscheme oxocarbon]]

  vim.lsp.config("harper_ls", {
    settings = {
      ["harper-ls"] = {
        userDictPath = "",
        workspaceDictPath = "",
        fileDictPath = "",
        linters = {
          SpellCheck = true,
          SpelledNumbers = false,
          AnA = true,
          SentenceCapitalization = true,
          UnclosedQuotes = true,
          WrongQuotes = false,
          LongSentences = true,
          RepeatedWords = true,
          Spaces = true,
          Matcher = true,
          CorrectNumberSuffix = true
        },
        codeActions = {
          ForceStable = false
        },
        markdown = {
          IgnoreLinkTitle = false
        },
        diagnosticSeverity = "hint",
        isolateEnglish = false,
        dialect = "American",
        maxFileLength = 120000,
        ignoredLintsPath = "",
        excludePatterns = {}
      }
    }
  })
end)
