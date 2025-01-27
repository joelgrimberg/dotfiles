return {
  -- Autocompletion
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    -- Snippet Engine & its associated nvim-cmp source
    {
      "L3MON4D3/LuaSnip",
      build = "make install_jsregexp",
    },
    "saadparwaiz1/cmp_luasnip",

    -- Adds LSP completion capabilities
    "hrsh7th/cmp-nvim-lsp",

    -- Adds a number of user-friendly snippets
    -- 'rafamadriz/friendly-snippets',
  },
  ------@param opts cmp.ConfigSchema
  ---opts = function(_, opts)
  ---  local cmp = require("cmp")
  ---
  ---  opts.mapping = vim.tbl_extend("force", opts.mapping, {
  ---    ["<Tab>"] = cmp.mapping(function(fallback)
  ---      -- This little snippet will confirm with tab, and if no entry is selected, will confirm the first item
  ---      if cmp.visible() then
  ---        local entry = cmp.get_selected_entry()
  ---        if not entry then
  ---          cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
  ---        else
  ---          cmp.confirm()
  ---        end
  ---      else
  ---        fallback()
  ---      end
  ---    end, { "i", "s", "c" }),
  ---  })
  ---end,
  config = function()
    local cmp = require("cmp")
    cmp.setup({
      sources = {
        { name = "nvim_lsp", option = { markdown_oxide = { keyword_pattern = [[\(\k\| \|\/\|#\)\+]] } } },
        -- other sources can be added here
      },
    })
  end,
}
