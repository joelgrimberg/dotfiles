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

          -- -- Mappings
          -- buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
          -- buf_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
          -- buf_set_keymap("n", "gi", "<Cmd>lua vim.lsp.buf.implementation()<CR>", opts)
          -- buf_set_keymap("n", "<C-k>", "<Cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
          -- buf_set_keymap("n", "<space>wa", "<Cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
          -- buf_set_keymap("n", "<space>wr", "<Cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
          -- buf_set_keymap(
          --   "n",
          --   "<space>wl",
          --   "<Cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
          --   opts
          -- )
          -- buf_set_keymap("n", "<space>D", "<Cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
          -- buf_set_keymap("n", "<space>rn", "<Cmd>lua vim.lsp.buf.rename()<CR>", opts)
          -- buf_set_keymap("n", "gr", "<Cmd>lua vim.lsp.buf.references()<CR>", opts)
          -- buf_set_keymap("n", "<space>e", "<Cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
          -- buf_set_keymap("n", "[d", "<Cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
          -- buf_set_keymap("n", "]d", "<Cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
          -- buf_set_keymap("n", "<space>q", "<Cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
          -- buf_set_keymap("n", "<space>f", "<Cmd>lua vim.lsp.buf.formatting()<CR>", opts)
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
