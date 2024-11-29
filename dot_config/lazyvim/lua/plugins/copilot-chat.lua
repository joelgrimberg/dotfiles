return {
  "CopilotC-Nvim/CopilotChat.nvim",
  keys = {
    { "<C-M-s>", "<cmd>CopilotChatToggle<cr>", desc = "Toggle CopilotChat" },
    { "<C-M-h>", "<cmd>wincmd h<cr>", desc = "Move to left window" },
    { "<C-M-l>", "<cmd>wincmd l<cr>", desc = "Move to right window" },
  },
  branch = "canary",
  dependencies = {
    { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
    { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
  },
  build = "make tiktoken", -- Only on MacOS or Linux
  opts = {
    debug = true, -- Enable debugging
    window = {

      width = 80,
      col = 5, -- 50% width
    },
    -- See Configuration section for rest
  },
  -- See Commands section for default commands if you want to lazy load on them
}
