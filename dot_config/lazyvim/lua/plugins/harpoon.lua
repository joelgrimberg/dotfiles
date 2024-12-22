-- Project specific marks for most editable files
-- Project specific marks for most editable files
-- Project specific marks for most editable files
return
-- Project specific marks for most editable files
{
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  commit = "e76cb03",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require("harpoon")
    harpoon:setup({
      settings = {
        save_on_toggle = true,
        mark_branch = true,
        excluded_filetypes = { "harpoon", "NvimTree", "TelescopePrompt" },
      },
      projects = {
        ["$HOME/dev/"] = {
          mark = {
            marks = { "1", "2", "3", "4", "5" },
            sign = false,
            hl = "String",
            numhl = "Comment",
            size = 1,
            hidden = false,
            stacked = false,
          },
        },
      },
    })

    vim.keymap.set("n", "<leader>h", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { noremap = true, desc = "Harpoon view" })

    vim.keymap.set("n", "<leader>a", function()
      harpoon:list():add()
    end, { noremap = true, desc = "Harpoon this path" })

    vim.keymap.set("n", "<leader>q", function()
      harpoon:list():select(1)
    end, { desc = "Harpoon #1" })
    vim.keymap.set("n", "<leader>w", function()
      harpoon:list():select(2)
    end, { desc = "Harpoon #2" })
    vim.keymap.set("n", "<leader>x", function()
      harpoon:list():select(3)
    end, { desc = "Harpoon #3" })
    vim.keymap.set("n", "<leader>r", function()
      harpoon:list():select(4)
    end, { desc = "Harpoon #4" })
    vim.keymap.set("n", "<leader>t", function()
      harpoon:list():select(5)
    end, { desc = "Harpoon #5" })
  end,
}
