return {
  "NvChad/nvterm",
  event = "BufWinEnter",
  opts = {
    terminals = {
      type_opts = {
        horizontal = {
          split_ratio = ((IS_STREAMING or vim.api.nvim_get_option_value("lines", {}) < 60) and 0.5) or 0.35,
        },
      },
    },
  },
  init = function()
    vim.keymap.set({ "n", "t" }, "<D-S-c>", function()
      require("nvterm.terminal").toggle("horizontal")
    end, {})
  end,
}
