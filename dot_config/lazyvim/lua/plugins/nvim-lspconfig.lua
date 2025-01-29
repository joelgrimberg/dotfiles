return {
  -- LSP Configuration & Plugins
  "neovim/nvim-lspconfig",
  dependencies = {
    -- Automatically install LSPs to stdpath for neovim
    { "williamboman/mason.nvim", config = true },
    {
      "williamboman/mason-lspconfig.nvim",
      config = function()
        local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

        -- Define the on_attach function
        local on_attach = function(client, bufnr)
          -- Example key mappings
          local function buf_set_keymap(...)
            vim.api.nvim_buf_set_keymap(bufnr, ...)
          end
          local opts = { noremap = true, silent = true }
        end

        require("lspconfig").markdown_oxide.setup({
          capabilities = vim.tbl_deep_extend("force", capabilities, {
            workspace = {
              didChangeWatchedFiles = {
                dynamicRegistration = true,
              },
            },
          }),
          on_attach = on_attach,
        })
      end,
    },
    -- Additional lua configuration, makes nvim stuff amazing!
    "folke/neodev.nvim",
    -- Autocompletion plugin
    "hrsh7th/nvim-cmp",
    -- LSP source for nvim-cmp
    "hrsh7th/cmp-nvim-lsp",
  },
}
