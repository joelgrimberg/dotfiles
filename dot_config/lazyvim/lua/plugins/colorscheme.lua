return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    -- cond = if_not_vscode,
    priority = 1000,
    opts = {
      transparent_background = true,
      integrations = {
        treesitter = true,

        telescope = true,
        notify = true,
        gitsigns = true,
        noice = true,
        dap = true,
        dap_ui = true,
        nvimtree = true,
      },
    },
    init = function()
      local catpuccin = require("catppuccin.palettes.mocha")
      vim.cmd.colorscheme("catppuccin")
      vim.api.nvim_set_hl(0, "LspInlayHint", { bg = catpuccin.base, fg = catpuccin.overlay0 })
      vim.api.nvim_set_hl(0, "WinSeparator", { bg = catpuccin.mantle, fg = catpuccin.surface1 })
      vim.api.nvim_set_hl(0, "TreesitterContextBottom", { sp = catpuccin.surface2, underline = false })
      vim.api.nvim_set_hl(0, "TreesitterContextLineNumberBottom", { sp = catpuccin.surface2, underline = false })
    end,

    -- Specific configuration for vscode-nvim
  },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin-mocha",
    },
  },
}
