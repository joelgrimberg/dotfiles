return {
  "rmagatti/auto-session",
  opts = {
    log_level = "error",
    auto_session_suppress_dirs = { "~/", "~/Downloads", "/" },
    bypass_session_save_file_types = { "help", "alpha", "telescope" },
  },
  init = function()
    vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
  end,
}
