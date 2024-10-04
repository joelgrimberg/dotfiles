return {
  {
    "folke/edgy.nvim",
    event = "VeryLazy",
    init = function()
      local edgy = require "edgy"
      local catpuccin = require "catppuccin.palettes.mocha"

      vim.opt.splitkeep = "screen"

      vim.api.nvim_set_hl(0, "EdgyWinBar", { bg = catpuccin.mantle })
      vim.api.nvim_set_hl(0, "EdgyNormal", { bg = catpuccin.mantle })

      vim.keymap.set("n", "<D-b>", function()
        edgy.toggle "right"
      end, { desc = "Toggle sidebar" })
    end,
    dependencies = {
      {
        "folke/trouble.nvim",
        keys = {
          {
            "<leader>tm",
            "<cmd>Trouble diagnostics toggle<cr>",
            desc = "Diagnostics (Trouble)",
          },
          {
            "<leader>tt",
            "<cmd>Trouble symbols toggle<cr>",
            desc = "Symbols (Trouble)",
          },
          {
            "<leader>tl",
            "<cmd>Trouble loclist toggle<cr>",
            desc = "Location List (Trouble)",
          },
        },
        opts = {
          restore = false,
          auto_close = false,
          auto_preview = true,
          open_no_results = true,
          pinned = true,
          multiline = false,
          filter = {
            -- remove Package since luals uses it for control flow structures
            ["not"] = { ft = "lua", kind = "Package" },
            any = {
              -- all symbol kinds for help / markdown files
              ft = { "help", "markdown" },
              -- default set of symbol kinds
              kind = {
                "Class",
                "Constructor",
                "Enum",
                "Field",
                "Function",
                "Interface",
                "Method",
                "Module",
                "Namespace",
                "Package",
                "Property",
                "Struct",
                "Trait",
              },
            },
          },
        }, -- for default options, refer to the configuration section for custom setup.
        init = function()
          vim.api.nvim_create_autocmd("BufReadPost", {
            pattern = "*",
            callback = function()
              require("trouble").refresh()
            end,
          })
        end,
      },
    },
    opts = {
      options = {
        right = {
          size = 35,
        },
      },
      exit_when_last = true,
      close_when_all_hidden = false,
      right = {
        {
          ft = "trouble",
          pinned = true,
          title = "Sidebar",
          filter = function(_buf, win)
            return vim.w[win].trouble.mode == "symbols"
          end,
          open = "Trouble symbols position=right focus=false filter.buf=0",
          size = { height = 0.6 },
        },
        {
          ft = "trouble",
          pinned = true,
          title = "Troubles",
          filter = function(_buf, win)
            return vim.w[win].trouble.mode == "diagnostics"
          end,
          open = "Trouble diagnostics focus=false filter.severity=vim.diagnostic.severity.HINT",
          size = { height = 0.4 },
        },
      },
    },
  },
}
