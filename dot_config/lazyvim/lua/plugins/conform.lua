return {
  "stevearc/conform.nvim",
  require("conform").setup({
    formatters_by_ft = {
      lua = { "stylua" },
      rust = { "rustfmt" },
      c = { "clang-format" },
      cpp = { "clang-format" },
      python = { "isort", "black" },
      javascript = { "prettierd", "prettier" },
      markdown = { "prettierd", "prettier" },
      typescript = { "prettierd", "prettier" },
      typescriptreact = { "prettierd", "prettier" },
      css = { "prettierd", "prettier" },
      svg = { "xmlformat" },
    },
    json = { "prettierd", "prettier" },
    yaml = { "prettierd", "prettier" },
    graphql = { "prettierd", "prettier" },
    rescript = { "rescript-format" },
    ocaml = { "ocamlformat" },
    sql = { "pg_format" },
  }),

  --   local function format()
  --     require("conform").format({
  --       lsp_fallback = true,
  --     })
  --   end
  --
  --   vim.keymap.set({ "n", "i" }, "<F12>", format, { desc = "Format", silent = true })
  --   vim.api.nvim_create_user_command("Format", format, { desc = "Format current buffer with LSP" })
  -- end,
}
