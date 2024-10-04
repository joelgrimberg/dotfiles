local function lazy(opts)
  return {
    "goolord/alpha-nvim",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local status_ok, alpha = pcall(require, "alpha")
      if not status_ok then
        return
      end

      local dashboard = require "alpha.themes.dashboard"

      if opts.header == "pikachu" then
        dashboard.section.header.val = {
          [[          ▀████▀▄▄              ▄█ ]],
          [[            █▀    ▀▀▄▄▄▄▄    ▄▄▀▀█ ]],
          [[    ▄        █          ▀▀▀▀▄  ▄▀  ]],
          [[   ▄▀ ▀▄      ▀▄              ▀▄▀  ]],
          [[  ▄▀    █     █▀   ▄█▀▄      ▄█    ]],
          [[  ▀▄     ▀▄  █     ▀██▀     ██▄█   ]],
          [[   ▀▄    ▄▀ █   ▄██▄   ▄  ▄  ▀▀ █  ]],
          [[    █  ▄▀  █    ▀██▀    ▀▀ ▀▀  ▄▀  ]],
          [[   █   █  █      ▄▄           ▄▀   ]],
        }
      else
        dashboard.section.header.val = {
          [[    _____                _     _                          ]],
          [[   / ____|              (_)   | |                         ]],
          [[  | |     ___  _ __  ___ _ ___| |_ ___ _ __   ___ _   _   ]],
          [[  | |    / _ \| '_ \/ __| / __| __/ _ \ '_ \ / __| | | |  ]],
          [[  | |___| (_) | | | \__ \ \__ \ ||  __/ | | | (__| |_| |  ]],
          [[   \_____\___/|_| |_|___/_|___/\__\___|_| |_|\___|\__, |  ]],
          [[                                                   __/ |  ]],
          [[                                                  |___/   ]],
        }
      end

      dashboard.section.buttons.val = {
        dashboard.button("l", "󱐋 Ohra Training", "<cmd>e ~/code/active_projects/ohra_training<CR>:SessionRestore<CR>"),
        dashboard.button("t", "🎯 deTesters", "<cmd>e ~/code/deTesters/log<CR>:SessionRestore<CR>"),
        dashboard.button(
          "--------------------------------------------------",
          " ",
          ":echo 'do the work '<CR>"
        ),
        dashboard.button("p", "  Projects", "<cmd>Telescope projects<CR>"),
        dashboard.button("a", "  New file", "<cmd>ene <BAR> startinsert <CR>"),
        dashboard.button("c", "󰢻  Configuration", "<cmd>e ~/.config/nvim/init.lua<CR>"),
        dashboard.button("q", "󰩈  Quit Neovim", "<cmd>qa<CR>"),
      }

      local function footer()
        return "do epic stuff"
      end

      dashboard.section.footer.val = footer()
      dashboard.section.footer.opts.hl = "Type"
      dashboard.section.header.opts.hl = "Include"
      dashboard.section.buttons.opts.hl = "Keyword"

      dashboard.opts.opts.noautocmd = true
      alpha.setup(dashboard.opts)
    end,
  }
end

return {
  lazy = lazy,
}
