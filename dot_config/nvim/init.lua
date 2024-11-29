vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.kitty_fast_forwarded_modifiers = "super"

vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4

local IS_STREAMING = os.getenv "STREAM" ~= nil
if IS_STREAMING then
  vim.print "Subscribe to my twitter @goose_plus_plus"
end

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Make line numbers default
vim.wo.number = true
vim.wo.relativenumber = true

-- Enale mouse mode
vim.o.mouse = "a"
vim.o.foldmethod = "manual"

-- Sync clipboard between OS and Neovim.
--  move this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = "unnamedplus"
vim.o.showmode = false

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = "yes"

--  Set timeout for key sequences
vim.o.timeout = true
vim.o.timeoutlen = 250

-- Set the scolloff
vim.o.scrolloff = 10
-- Highlight current line as cursor
vim.o.cursorline = true

-- set termguicolors to enable highlight groups
vim.o.termguicolors = true

-- Renders spaces as "·"
vim.opt.list = true
vim.opt.listchars = vim.opt.listchars + "space:·"

-- Do not create swap files as this config autosaving everything on disk
vim.opt.swapfile = false

-- Set terminal tab title to `filename (cwd)`
vim.opt.title = true
vim.o.titlestring = '∀ %{fnamemodify(getcwd(), ":t")}->>%{expand("%:t")}'

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- Specific configuration for vscode-nvim
local if_not_vscode = function()
  return not vim.g.vscode
end

require("lazy").setup({
  "mfussenegger/nvim-lint",
  optional = true,
  opts = {
    linters = {
      -- https://github.com/LazyVim/LazyVim/discussions/4094#discussioncomment-10178217
      ["markdownlint-cli2"] = {
        args = { "--config", os.getenv "HOME" .. ".markdownlint.yaml" },
      },
    },
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      signs = true, -- show icons in the signs column
      sign_priority = 8, -- sign priority
      -- keywords recognized as todo comments
      keywords = {
        FIX = {
          icon = " ", -- icon used for the sign, and in search results
          color = "error", -- can be a hex color, or a named color (see below)
          alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
          -- signs = false, -- configure signs for some keywords individually
        },
        TODO = { icon = " ", color = "info" },
        HACK = { icon = " ", color = "warning" },
        WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
        PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
        NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
        TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
      },
      gui_style = {
        fg = "NONE", -- The gui style to use for the fg highlight group.
        bg = "BOLD", -- The gui style to use for the bg highlight group.
      },
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  },
  {
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
  },

  "github/copilot.vim",
  -- Git management
  "tpope/vim-fugitive",
  -- Allows cursor locations in the :e
  "lewis6991/fileline.nvim",
  -- Code actions preview using telescope
  "aznhe21/actions-preview.nvim",
  -- Multi cursor support
  "mg979/vim-visual-multi",
  --  Automatically jump to the last cursor position
  "farmergreg/vim-lastplace",
  -- Turn off some of the feature on big buffers
  "LunarVim/bigfile.nvim",
  {
    -- A better code actions menu
    "weilbith/nvim-code-action-menu",
    event = "BufWinEnter",
    config = function()
      require("actions-preview").setup {
        diff = {
          algorithm = "minimal",
          ignore_whitespace = true,
        },
      }
    end,
  },
  { "chentoast/marks.nvim", event = "VeryLazy", opts = {} },
  -- {
  --   "luckasRanarison/tailwind-tools.nvim",
  --   opts = {
  --     custom_filetypes = {
  --       "rescript",
  --     },
  --   }
  -- },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      file_types = { "markdown" },
    },
    ft = { "markdown" },
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
  },
  {
    "stevearc/oil.nvim",
    lazy = true,
    cmd = "Oil",
    keys = {
      { "<D-o>", "<cmd>Oil<CR>", silent = true, desc = "Open Oil" },
    },
    opts = {
      keymaps = {
        ["<D-i>"] = "actions.select",
        ["yp"] = {
          desc = "Copy filepath to system clipboard",
          callback = function()
            require("oil.actions").copy_entry_path.callback()
            vim.fn.setreg("+", vim.fn.getreg(vim.v.register))
            vim.notify("Copied full path", "info", { title = "Oil" })
          end,
        },
      },
      default_file_explorer = false,
      delete_to_trash = true,
      lsp_file_methods = {
        autosave_changes = true,
      },
    },
  },
  -- Detect tabstop and shiftwidth automatically
  "tpope/vim-sleuth",
  -- Camel case motion plugin
  {
    "bkad/CamelCaseMotion",
    event = "VeryLazy",
    init = function()
      vim.g.camelcasemotion_key = "q"
    end,
  },
  -- Allows correctly opening and closing nested nvims in the terminal
  {
    "samjwill/nvim-unception",
    event = "VeryLazy",
    init = function()
      vim.g.unception_delete_replaced_buffer = true
      vim.api.nvim_create_autocmd("User", {
        pattern = "UnceptionEditRequestReceived",
        callback = function()
          require("nvterm.terminal").hide "horizontal"
        end,
      })
    end,
  },
  -- Handy rename in a floating method
  {
    "filipdutescu/renamer.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
  },
  {
    "mrcjkb/rustaceanvim",
    lazy = false,
  },
  { "akinsho/git-conflict.nvim", version = "*", config = true },
  {
    "ruifm/gitlinker.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("gitlinker").setup()
      vim.api.nvim_set_keymap(
        "n",
        "<leader>gg",
        '<cmd>lua require"gitlinker".get_buf_range_url("n", {action_callback = require"gitlinker.actions".open_in_browser})<cr>',
        { silent = true, desc = "Open git link in the browser" }
      )
    end,
  },
  -- Toggle terminal plugin
  {
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
        require("nvterm.terminal").toggle "horizontal"
      end, {})
    end,
  },

  -- NOTE: This is here your plugins related to LSP can be installed.
  --  The configuration is done below. Search for lspconfig to find it below.
  {
    -- LSP Configuration & Plugins
    "neovim/nvim-lspconfig",
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      { "williamboman/mason.nvim", config = true },
      "williamboman/mason-lspconfig.nvim",
      -- Additional lua configuration, makes nvim stuff amazing!
      "folke/neodev.nvim",
    },
  },

  {
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
  },

  {
    -- Adds git related signs to the gutter, as well as utilities for managing changes
    "lewis6991/gitsigns.nvim",
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = "┃" },
        change = { text = "┃" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "┆" },
      },
      on_attach = function(bufnr)
        vim.keymap.set(
          "n",
          "<leader>gp",
          require("gitsigns").prev_hunk,
          { buffer = bufnr, desc = "[G]o to [P]revious Hunk" }
        )
        vim.keymap.set(
          "n",
          "<leader>gn",
          require("gitsigns").next_hunk,
          { buffer = bufnr, desc = "[G]it go to [N]ext Hunk" }
        )
        vim.keymap.set(
          "n",
          "<leader>gd",
          require("gitsigns").preview_hunk,
          { buffer = bufnr, desc = "[G]it [D]iff Hunk" }
        )

        vim.keymap.set(
          "n",
          "<leader>gr",
          require("gitsigns").reset_hunk,
          { buffer = bufnr, desc = "[G]it [R]eset hunk" }
        )
        vim.keymap.set(
          "n",
          "<leader>gb",
          require("gitsigns").toggle_current_line_blame,
          { buffer = bufnr, desc = "[G]it [B]lame" }
        )
      end,
    },
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    cond = if_not_vscode,
    priority = 1000,
    opts = {
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
      local catpuccin = require "catppuccin.palettes.mocha"
      vim.cmd.colorscheme "catppuccin"
      vim.api.nvim_set_hl(0, "LspInlayHint", { bg = catpuccin.base, fg = catpuccin.overlay0 })
      vim.api.nvim_set_hl(0, "WinSeparator", { bg = catpuccin.mantle, fg = catpuccin.surface1 })
      vim.api.nvim_set_hl(0, "TreesitterContextBottom", { sp = catpuccin.surface2, underline = false })
      vim.api.nvim_set_hl(0, "TreesitterContextLineNumberBottom", { sp = catpuccin.surface2, underline = false })
    end,
  },
  {
    priority = 1000,
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      {
        "linrongbin16/lsp-progress.nvim",
        opts = {
          format = function(client_messages)
            local api = require "lsp-progress.api"
            local lsp_clients = #api.lsp_clients()
            if #client_messages > 0 then
              return table.concat(client_messages, " ")
            elseif lsp_clients > 0 then
              return "󰄳 LSP " .. lsp_clients .. " clients"
            end
            return ""
          end,
        },
      },
    },
    cond = function()
      return os.getenv "PRESENTATION" ~= "true"
    end,
    config = function()
      vim.api.nvim_create_augroup("lualine_augroup", { clear = true })
      vim.api.nvim_create_autocmd("User", {
        group = "lualine_augroup",
        pattern = "LspProgressStatusUpdated",
        callback = require("lualine").refresh,
      })
      local catpuccin = require "catppuccin.palettes.mocha"

      local custom_catppuccin_theme = {
        normal = {
          a = { fg = catpuccin.crust, bg = catpuccin.mauve },
          b = { fg = catpuccin.mauve, bg = catpuccin.base },
          c = { fg = catpuccin.subtext0, bg = catpuccin.base },
        },

        insert = { a = { fg = catpuccin.base, bg = catpuccin.peach, gui = "bold" } },
        visual = { a = { fg = catpuccin.base, bg = catpuccin.sky } },
        replace = { a = { fg = catpuccin.base, bg = catpuccin.green } },

        inactive = {
          a = { fg = catpuccin.text, bg = catpuccin.surface0 },
          b = { fg = catpuccin.text, bg = catpuccin.surface0 },
          c = { fg = catpuccin.text, bg = catpuccin.surface0 },
        },
      }

      local function wordcount()
        return tostring(vim.fn.wordcount().words) .. " words"
      end

      local function readingtime()
        return tostring(math.ceil(vim.fn.wordcount().words / 200.0)) .. " min"
      end

      local function is_markdown()
        return vim.bo.filetype == "markdown" or vim.bo.filetype == "asciidoc"
      end

      require("lualine").setup {
        options = {
          disabled_filetypes = {
            statusline = { "alpha", "NvimTree", "trouble" },
          },
          theme = custom_catppuccin_theme,
          component_separators = "|",
          section_separators = "",
        },
        sections = {
          lualine_c = {
            function()
              -- invoke `progress` here.
              return require("lsp-progress").progress()
            end,
          },
          lualine_x = { "filetype" },
          lualine_y = {
            { wordcount, cond = is_markdown },
            { readingtime, cond = is_markdown },
          },
          lualine_z = { { "os.date('󱑈 %H:%M')", color = { fg = "#363a4f", gui = "bold" } } },
        },
      }
    end,
  },

  {
    -- Add indentation guides even on blank lines
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
      indent = {
        char = "┊",
      },
      scope = {
        show_start = false,
        show_end = false,
      },
    },
    -- cond = function() return false end
  },

  -- Surround text objects with quotes, brackets, etc
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    opts = {},
  },

  -- Automatically fill/change/remove xml-like tags
  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
    opts = {
      opts = {
        -- Defaults
        enable_close = true, -- Auto close tags
        enable_rename = true, -- Auto rename pairs of tags
        enable_close_on_slash = false, -- Auto close on trailing </
      },
    },
  },

  -- Project specific marks for most editable files
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    commit = "e76cb03",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local harpoon = require "harpoon"
      harpoon:setup {
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
      }

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
  },
  {
    "jmbuhr/otter.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {},
  },
  {
    -- Highlight, edit, and navigate code
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      -- Custom treesitter parserrs
      "rescript-lang/tree-sitter-rescript",
      "danielo515/tree-sitter-reason",
      "IndianBoy42/tree-sitter-just",
      {
        "nvim-treesitter/nvim-treesitter-context",
        opts = {
          max_lines = IS_STREAMING and 1 or 3,
        },
      },
    },
    build = ":TSUpdate",
    config = function()
      -- [[ Configure Treesitter ]]
      -- See `:help nvim-treesitter`
      require("nvim-treesitter.configs").setup {
        -- Add languages to be installed here that you want installed for treesitter
        ensure_installed = {
          "c",
          "cpp",
          "go",
          "lua",
          "python",
          "rust",
          "tsx",
          "typescript",
          "vimdoc",
          "vim",
          -- "rescript",
          "markdown",
          "markdown_inline",
          "wgsl",
          "html",
          "ocaml",
        },

        -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
        auto_install = true,
        highlight = {
          enable = true,
          use_languagetree = true,
          additional_vim_regex_highlighting = { "markdown" },
        },
        indent = { enable = true },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<c-space>",
            node_incremental = "<c-space>",
            scope_incremental = "<c-s>",
            node_decremental = "<S-space>",
          },
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ["ap"] = "@parameter.outer",
              ["ip"] = "@parameter.inner",
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
              ["as"] = "@statement.outer",
              ["is"] = "@statement.inner",
              ["av"] = "@assignment.outer",
              ["iv"] = "@assignment.inner",
            },
          },
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              ["]{"] = "@function.outer",
              ["]c"] = "@class.outer",
            },
            goto_next_end = {
              ["]}"] = "@function.outer",
              ["]C"] = "@class.outer",
            },
            goto_previous_start = {
              ["[{"] = "@function.outer",
              ["[c"] = "@class.outer",
            },
            goto_previous_end = {
              ["[}"] = "@function.outer",
              ["[C"] = "@class.outer",
            },
          },
          swap = {
            enable = true,
            swap_next = {
              ["<A-p>"] = "@parameter.inner",
            },
            swap_previous = {
              ["<A-P>"] = "@parameter.inner",
            },
          },
        },
      }

      require("nvim-treesitter.install").compilers = { "gcc", "clang" }
      local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

      parser_config.just = {
        install_info = {
          url = "https://github.com/IndianBoy42/tree-sitter-just", -- local path or git repo
          files = { "src/parser.c", "src/scanner.cc" },
          branch = "main",
          use_makefile = true, -- this may be necessary on MacOS (try if you see compiler errors)
        },
        maintainers = { "@IndianBoy42" },
      }

      parser_config.rescript = {
        install_info = {
          url = "https://github.com/rescript-lang/tree-sitter-rescript",
          branch = "main",
          files = { "src/parser.c", "src/scanner.c" },
          generate_requires_npm = false,
          requires_generate_from_grammar = true,
          use_makefile = true, -- macOS specific instruction
        },
      }
    end,
  },

  -- A lightbulb highlight for code actions
  {
    "kosayoda/nvim-lightbulb",
    lazy = false,
    config = function()
      require("nvim-lightbulb").setup {
        autocmd = { enabled = true },
      }
    end,
  },

  {
    "saecki/crates.nvim",
    event = "BufRead Cargo.toml",
    opts = {
      completion = {
        cmp = {
          enabled = true,
        },
      },
    },
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      enable_check_bracket_line = false,
    },
    init = function()
      local npairs = require "nvim-autopairs"
      local rule = require "nvim-autopairs.rule"
      local cond = require "nvim-autopairs.conds"

      npairs.add_rules { rule("|", "|", { "rust", "go", "lua" }):with_move(cond.after_regex "|") }
    end,
  },

  -- Global search and replace within cwd
  {
    "nvim-pack/nvim-spectre",
    opts = {},
    keys = {
      {
        mode = "n",
        "<D-S-r>",
        "<cmd>lua require('spectre').toggle()<CR>",
      },
      {
        mode = "v",
        "<D-S-r>",
        ":lua require('spectre').open_visual()<CR>",
      },
    },
  },

  -- Better notifications and messagess
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      presets = {
        lsp_doc_border = false,
      },
      lsp = {
        progress = {
          enabled = false,
        },
      },
      notify = {
        view = "mini",
      },
      routes = {
        {
          filter = {
            event = "notify",
            find = "No information available",
          },
          opts = { skip = true },
        },
      },
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
  },

  {
    "stevearc/conform.nvim",
    config = function()
      require("conform").setup {
        formatters_by_ft = {
          lua = { "stylua" },
          rust = { "rustfmt" },
          c = { "clang-format" },
          cpp = { "clang-format" },
          python = { "isort", "black" },
          javascript = { "prettierd", "prettier" },
          markdown = { "prettierd", "prettier" },
          typescript = { "prettierd", "prettier" },
          typescriptreact = { "prettierd", "prettier" },
          css = { "prettierd", "prettier" },
          svg = { "xmlformat" },
        },
        json = { "prettierd", "prettier" },
        yaml = { "prettierd", "prettier" },
        graphql = { "prettierd", "prettier" },
        rescript = { "rescript-format" },
        ocaml = { "ocamlformat" },
        sql = { "pg_format" },
      }

      local function format()
        require("conform").format {
          lsp_fallback = true,
        }
      end

      vim.keymap.set({ "n", "i" }, "<F12>", format, { desc = "Format", silent = true })
      vim.api.nvim_create_user_command("Format", format, { desc = "Format current buffer with LSP" })
    end,
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "modern",
    },
    -- keys = {
    -- mode = { "n", "v" },
    -- { "<leader>mf", group = "[P]fold" },
    -- },
  },

  {
    "dmtrkovalenko/project.nvim",
    config = function()
      require("project_nvim").setup {
        detection_methods = { "pattern" },
        patterns = { ".git", ".sl" },
        after_project_selection_callback = function()
          vim.notify "SessionRestore"
        end,
      }
    end,
  },

  {
    "rmagatti/auto-session",
    opts = {
      log_level = "error",
      auto_session_suppress_dirs = { "~/", "~/Downloads", "/" },
      bypass_session_save_file_types = { "help", "alpha", "telescope" },
    },
    init = function()
      vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
    end,
  },

  {
    "folke/ts-comments.nvim",
    event = "VeryLazy",
    opts = {},
  },

  {
    "dmtrKovalenko/caps-word.nvim",
    -- dir = "~/dev/caps-word.nvim",
    lazy = true,
    opts = {
      enter_callback = function()
        vim.notify("On", vim.log.levels.INFO, { title = "Caps Word:" })
      end,
      exit_callback = function()
        vim.notify("Off", vim.log.levels.INFO, { title = "Caps Word:" })
      end,
    },
    keys = {
      {
        mode = { "i", "n" },
        "<C-s>",
        "<cmd>lua require('caps-word').toggle()<CR>",
      },
    },
  },

  {
    "Zeioth/markmap.nvim",
    build = "yarn global add markmap-cli",
    cmd = { "MarkmapOpen", "MarkmapSave", "MarkmapWatch", "MarkmapWatchStop" },
    opts = {
      html_output = "markmap.html", -- (default) Setting a empty string "" here means: [Current buffer path].html
      hide_toolbar = false, -- (default)
      grace_period = 3600000, -- (default) Stops markmap watch after 60 minutes. Set it to 0 to disable the grace_period.
    },
    config = function(_, opts)
      require("markmap").setup(opts)
    end,
  },

  -- Follow up with the custom reusable configuration for plugins located in ~/lua folder
  require("telescope-lazy").lazy {},
  require("alpha-lazy").lazy {},
  require("dap-lazy").lazy {},
  require("hop-lazy").lazy {},
  require("go").lazy {},
  require "sidebar",
}, {})

-- require('avante_lib').load()

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    local params = vim.lsp.util.make_range_params()
    params.context = { only = { "source.organizeImports" } }
    -- buf_request_sync defaults to a 1000ms timeout. Depending on your
    -- machine and codebase, you may want longer. Add an additional
    -- argument after params if you find that you have to write the file
    -- twice for changes to be saved.
    -- E.g., vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
    for cid, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
          vim.lsp.util.apply_workspace_edit(r.edit, enc)
        end
      end
    end
    vim.lsp.buf.format { async = false }
  end,
})

-- [[ Custom Autocmds]]
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})

vim.api.nvim_create_autocmd({ "InsertLeave", "FocusLost", "BufLeave" }, {
  command = "silent! wa",
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "typescript", "typescriptreact", "javascript", "css", "html", "json", "yaml", "markdown" },
  callback = function()
    vim.opt.iskeyword:append { "-", "#", "$" }
  end,
})

-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = { "ocaml" },
--   callback = function()
--     vim.keymap.set("i", ";", " in")
--     vim.keymap.set("i", ";;", ";")
--   end,
-- })

vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  callback = function()
    vim.opt_local.wrap = false
  end,
})

vim.filetype.add { extension = { wgsl = "wgsl" } }

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set("n", "<D-e>", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set("n", "<D-S-m>", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- [[ Configure LSP ]]
--  This function gets run when an LSP connects to a particular buffer.
local on_lsp_attach = function(client, bufnr)
  local lsp_map = function(keys, func, desc)
    if desc then
      desc = "LSP: " .. desc
    end

    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc, silent = true })
  end

  -- setup Markdown Oxide daily note commands
  if client.name == "markdown_oxide" then
    vim.api.nvim_create_user_command("Daily", function(args)
      local input = args.args

      vim.lsp.buf.execute_command { command = "jump", arguments = { input } }
    end, { desc = "Open daily note", nargs = "*" })
  end

  -- if vim.bo.filetype == "rust" then
  --   lsp_map("<D-.>", ":RustLsp codeAction<CR>", "[C]ode [A]ction")
  --   vim.keymap.set("n", "<F4>", ":RustLsp debuggables<CR>", { silent = true, desc = "Rust: Debuggables" })
  -- else
  --   lsp_map("<D-.>", require("actions-preview").code_actions, "[C]ode [A]ction")
  -- end
  lsp_map("<A-S-.>", require("actions-preview").code_actions, "[C]ode [A]ction")

  lsp_map("<D-r>", require("renamer").rename, "[R]e[n]ame")

  lsp_map("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
  lsp_map("gD", vim.lsp.buf.definition, "[G]oto [D]eclaration")
  lsp_map("gi", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
  lsp_map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

  lsp_map("<D-g>", "<C-]>", "[G]oto [D]efinition")
  lsp_map("<D-A-g>", vim.lsp.buf.type_definition, "Type [D]efinition")

  lsp_map("<D-i>", vim.lsp.buf.hover, "Hover Documentation")
  lsp_map("<D-u>", vim.lsp.buf.signature_help, "Signature Documentation")

  lsp_map("<leader>ls", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
  lsp_map("<leader>lr", function()
    vim.cmd "LspRestart"
  end, "Lsp [R]eload")
  lsp_map("<leader>li", function()
    vim.cmd "LspInfo"
  end, "Lsp [R]eload")
  lsp_map("<leader>lh", function()
    local bufFitler = { bufnr }
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled(filter), filter)
  end, "Lsp toggle inlay [h]ints")
end

-- Enable the following language servers
local servers = {
  clangd = {
    filetypes = { "c", "cpp", "proto" },
    cmd = {
      "clangd",
      "--background-index",
      "--query-driver=/Users/dmtrkovalenko/.platformio/packages/toolchain-xtensa-esp32/bin/xtensa-esp32-elf-gcc",
      "--offset-encoding=utf-16",
    },
  },
  eslint = {
    filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact", "" },
  },
  ts_ls = {
    typescript = {
      inlayHints = {
        includeInlayEnumMemberValueHints = false,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayParameterNameHints = "literals", -- 'none' | 'literals' | 'all';
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayPropertyDeclarationTypeHints = false,
        includeInlayVariableTypeHints = true,
      },
    },
  },
  html = { filetypes = { "html", "twig", "hbs" } },
  lua_ls = {
    Lua = {
      runtime = {

        version = "LuaJIT",
      },
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
  typos_lsp = {
    single_file_support = false,
    init_options = { diagnosticSeverity = "WARN" },
  },
  markdown_oxide = {
    single_file_support = false,
    keyword_pattern = [[\(\k\| \|\/\|#\)\+]],
    init_options = { diagnosticSeverity = "WARN" },
  },
  marksman = {
    cmd = {
      "marksman",
      "server",
    },
    filetypes = { "markdown", "markdown.mdx" },
  },
  pylsp = {},
  astro = {},
}

-- Setup neovim lua configuration
require("neodev").setup()

-- An example nvim-lspconfig capabilities setting
local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

require("lspconfig").markdown_oxide.setup {
  -- Ensure that dynamicRegistration is enabled! This allows the LS to take into account actions like the
  -- Create Unresolved File code action, resolving completions for unindexed code blocks, ...
  capabilities = vim.tbl_deep_extend("force", capabilities, {
    workspace = {
      didChangeWatchedFiles = {
        dynamicRegistration = true,
      },
    },
  }),
  on_attach = on_attach, -- configure your on attach config
}

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
-- it then vim cmp overrides only completion part of the text document. leave all other preassigned
capabilities.textDocument.completion =
  require("cmp_nvim_lsp").default_capabilities(capabilities).textDocument.completion

-- optimizes cpu usage source https://github.com/neovim/neovim/issues/23291
-- capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = false

local signs = { Error = "󰚌 ", Warn = " ", Hint = "󱧡 ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.g.rustaceanvim = {
  -- Plugin configuration
  tools = {},
  -- LSP configuration
  server = {
    on_attach = on_lsp_attach,
    default_settings = {
      -- rust-analyzer language server configuration
      ["rust-analyzer"] = {
        check = {
          allTargets = false,
        },
        files = {
          excludeDirs = { "target", "node_modules", ".git", ".sl" },
        },
      },
    },
  },
  dap = {
    adapter = {
      type = "executable",
      command = "/opt/homebrew/opt/llvm/bin/lldb-vscode", -- adjust as needed, must be absolute path
      name = "lldb",
    },
  },
}

-- Ensure the servers above are installed
local mason_lspconfig = require "mason-lspconfig"

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require("lspconfig")[server_name].setup {
      capabilities = capabilities,
      on_attach = on_lsp_attach,
      settings = servers[server_name],
      single_file_support = (servers[server_name] or {}).single_file_support,
      filetypes = (servers[server_name] or {}).filetypes,
      cmd = (servers[server_name] or {}).cmd,
      init_options = (servers[server_name] or {}).init_options,
    }
  end,
}

-- In order to enforce using the ocaml lsp from the current switch/sandbox/esy env avoid using mason
-- and configure ocaml lsp manually.
require("lspconfig").ocamllsp.setup {
  capabilities = capabilities,
  on_attach = on_lsp_attach,
  settings = {},
}

require("lspconfig").gopls.setup {
  require("lspconfig").gopls.setup {
    on_attach = function(client, bufnr)
      mappings(client, bufnr)
      require("lsp-inlayhints").setup {
        inlay_hints = {
          parameter_hints = { prefix = "in: " }, -- "<- "
          type_hints = { prefix = "out: " }, -- "=> "
        },
      }
      require("lsp-inlayhints").on_attach(client, bufnr)
      require("illuminate").on_attach(client)

      -- workaround for gopls not supporting semanticTokensProvider
      -- https://github.com/golang/go/issues/54531#issuecomment-1464982242
      if not client.server_capabilities.semanticTokensProvider then
        local semantic = client.config.capabilities.textDocument.semanticTokens
        client.server_capabilities.semanticTokensProvider = {
          full = true,
          legend = {
            tokenTypes = semantic.tokenTypes,
            tokenModifiers = semantic.tokenModifiers,
          },
          range = true,
        }
      end

      -- DISABLED: FixGoImports
      --
      -- Instead I use https://github.com/incu6us/goimports-reviser
      -- Via https://github.com/stevearc/conform.nvim
      --
      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        group = vim.api.nvim_create_augroup("FixGoImports", { clear = true }),
        pattern = "*.go",
        callback = function()
          -- ensure imports are sorted and grouped correctly
          local params = vim.lsp.util.make_range_params()
          params.context = { only = { "source.organizeImports" } }
          local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
          for _, res in pairs(result or {}) do
            for _, r in pairs(res.result or {}) do
              if r.edit then
                vim.lsp.util.apply_workspace_edit(r.edit, "UTF-8")
              else
                vim.lsp.buf.execute_command(r.command)
              end
            end
          end
        end,
      })

      -- DISABLED:
      -- I don't use revive separately anymore. It's only used via golangci-lint.
      --
      -- vim.keymap.set("n", "<leader><leader>lv",
      --                "<Cmd>cex system('revive -exclude vendor/... ./...') | cwindow<CR>",
      --                {
      --     noremap = true,
      --     silent = true,
      --     buffer = bufnr,
      --     desc = "lint project code (revive)"
      -- })
    end,
    settings = {
      -- https://go.googlesource.com/vscode-go/+/HEAD/docs/settings.md#settings-for
      -- https://www.lazyvim.org/extras/lang/go (borrowed some ideas from here)
      gopls = {
        analyses = {
          fieldalignment = false, -- find structs that would use less memory if their fields were sorted
          nilness = true,
          unusedparams = true,
          unusedwrite = true,
          useany = true,
        },
        codelenses = {
          gc_details = false,
          generate = true,
          regenerate_cgo = true,
          run_govulncheck = true,
          test = true,
          tidy = true,
          upgrade_dependency = true,
          vendor = true,
        },
        experimentalPostfixCompletions = true,
        hints = {
          assignVariableTypes = true,
          compositeLiteralFields = true,
          compositeLiteralTypes = true,
          constantValues = true,
          functionTypeParameters = true,
          parameterNames = true,
          rangeVariableTypes = true,
        },
        gofumpt = true,
        semanticTokens = true,
        -- DISABLED: staticcheck
        --
        -- gopls doesn't invoke the staticcheck binary.
        -- Instead it imports the analyzers directly.
        -- This means it can report on issues the binary can't.
        -- But it's not a good thing (like it initially sounds).
        -- You can't then use line directives to ignore issues.
        --
        -- Instead of using staticcheck via gopls.
        -- We have golangci-lint execute it instead.
        --
        -- For more details:
        -- https://github.com/golang/go/issues/36373#issuecomment-570643870
        -- https://github.com/golangci/golangci-lint/issues/741#issuecomment-1488116634
        --
        -- staticcheck = true,
        usePlaceholders = true,
      },
    },
    -- DISABLED: as it overlaps with `lvimuser/lsp-inlayhints.nvim`
    -- init_options = {
    --   usePlaceholders = true,
    -- }
  },
}

require("lspconfig").yamlls.setup {
  capabilities = {
    textDocument = {
      foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      },
    },
  },
  on_attach = on_lsp_attach,
  settings = {
    redhat = { telemetry = { enabled = false } },
    yaml = {
      keyOrdering = false,
      format = {
        enable = true,
      },
      validate = true,
      schemaStore = {
        -- Must disable built-in schemaStore support to use
        -- schemas from SchemaStore.nvim plugin
        enable = false,
        -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
        url = "",
      },
    },
  },
}

require("lspconfig").relay_lsp.setup {
  capabilities = capabilities,
  on_attach = on_lsp_attach,
  cmd = { "yarn", "relay-compiler", "lsp" },
  settings = {},
}

-- [[ Configure nvim-cmp ]]
-- See `:help cmp`
local cmp = require "cmp"
local luasnip = require "luasnip"

-- Loads all the snippets installed by extensions in vscode.
-- require('luasnip.loaders.from_vscode').lazy_load()
require("luasnip.loaders.from_vscode").load { paths = "~/.config/nvim/snippets" }

luasnip.config.set_config {
  region_check_events = "InsertEnter",
  delete_check_events = "InsertLeave",
}

luasnip.config.setup {}

-- Make sure that we can work with luasnip and copilot at the same time
vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  performance = { max_view_entries = 15 },
  mapping = cmp.mapping.preset.insert {
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-Enter>"] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    },
    ["<CR>"] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    },
    ["<Tab>"] = cmp.mapping(function(fallback)
      -- provide a value for copilot to fallback if there is no suggestion to accept. If no suggestion accept mimic normal tab behavior.
      local tab_shift_width = vim.opt.shiftwidth:get()
      local copilot_keys = vim.fn["copilot#Accept"](string.rep(" ", tab_shift_width))

      if luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      elseif copilot_keys ~= "" and type(copilot_keys) == "string" then
        vim.api.nvim_feedkeys(copilot_keys, "i", true)
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(falljack)
      if luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
  },
}

-- Set all the overrides and the extensions for the things that are available in native vim
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- My lovely vertical navigation speedups (do not add them to the jumplist)
vim.keymap.set("n", "<C-j>", "<cmd>keepjumps normal! }<CR>", { silent = true, remap = true })
vim.keymap.set("v", "<C-j>", "}", { silent = true, remap = true })
vim.keymap.set("n", "<C-k>", "<cmd>keepjumps normal! {<CR>", { silent = true, remap = true })
vim.keymap.set("v", "<C-k>", "{", { silent = true, remap = true })
vim.keymap.set({ "n", "v" }, "-", "$", { silent = true })

-- Move lines up and down
vim.api.nvim_set_keymap("n", "<A-j>", "V:move '>+1<CR>gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("x", "<A-j>", "<cmd>move '>+1<CR>gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<A-k>", "V:move '>-2<CR>gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("x", "<A-k>", "<cmd>move '<-2<CR>gv", { noremap = true, silent = true })

-- Make backspace work as black hole cut
vim.api.nvim_set_keymap("n", "<backspace>", '"_dh', { noremap = true })
vim.api.nvim_set_keymap("v", "<backspace>", '"_d', { noremap = true })

-- Write file on cmd+s
vim.api.nvim_set_keymap("n", "<D-s>", "w<CR>", { silent = true })
-- Open git
vim.api.nvim_set_keymap("n", "<A-g>", "<cmd>Git<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<D-S-g>", "<cmd>Git<CR>", { silent = true })

-- Move to next occurrence with multi cursor
vim.api.nvim_set_keymap("n", "<D-d>", "<C-n>", { silent = true })
vim.api.nvim_set_keymap("v", "<D-d>", "<C-n>", { silent = true })

-- Move to next occurrence using native search
vim.api.nvim_set_keymap("n", "<D-n>", "*", { silent = true })
vim.api.nvim_set_keymap("n", "<D-S-n>", "#", { silent = true })

-- Delete a word by alt+backspace
vim.api.nvim_set_keymap("i", "<A-BS>", "<C-w>", { noremap = true })
vim.api.nvim_set_keymap("n", "<A-BS>", "db", { noremap = true })

-- Select whole buffer
vim.api.nvim_set_keymap("n", "<D-a>", "ggVG", {})

-- FIXME Comment out lines
vim.api.nvim_set_keymap("n", "<D-/>", "gcc", {})
vim.api.nvim_set_keymap("v", "<D-/>", "gc", {})

-- Clear line with cd
vim.api.nvim_set_keymap("n", "cd", "0D", {})

-- Switch between buffers
vim.keymap.set("n", "H", "<cmd>bprevious<CR>", { silent = true })
vim.keymap.set("n", "L", "<cmd>bnext<CR>", { silent = true })

vim.keymap.set({ "n", "v" }, "<C-h>", "b", { silent = true })
vim.keymap.set({ "n", "v" }, "<C-l>", "w", { silent = true })

-- Duplicate lines
vim.api.nvim_set_keymap("v", "<D-C-Up>", "y`>p`<", { silent = true })
vim.api.nvim_set_keymap("n", "<D-C-Up>", "Vy`>p`<", { silent = true })
vim.api.nvim_set_keymap("v", "<D-C-Down>", "y`<p`>", { silent = true })
vim.api.nvim_set_keymap("n", "<D-C-Down>", "Vy`<p`>", { silent = true })

-- Map default <C-w> to the cmd+alt
vim.api.nvim_set_keymap("n", "<D-A-v>", "<C-w>v<C-w>w", { silent = true })
vim.api.nvim_set_keymap("n", "<D-A-s>", "<C-w>s<C-w>j", { silent = true })
vim.api.nvim_set_keymap("n", "<D-A-l>", "<C-w>l", { silent = true })
vim.api.nvim_set_keymap("n", "<D-A-h>", "<C-w>h", { silent = true })
vim.api.nvim_set_keymap("n", "<D-A-q>", "<C-w>q", { silent = true })
vim.api.nvim_set_keymap("n", "<D-A-j>", "<C-w>j", { silent = true })
vim.api.nvim_set_keymap("n", "<D-A-k>", "<C-w>k", { silent = true })

local function format_and_save()
  vim.cmd "Format"
  vim.cmd "w"
end

vim.keymap.set({ "n", "i" }, "<D-s>", format_and_save, { silent = true, desc = "Save file" })

-- Swap the p and P to not mess up the clipbard with replaced text
-- but leave the ability to paste the text
vim.keymap.set("x", "p", "P", {})
vim.keymap.set("x", "P", "p", {})

-- Exit terminal mode with Esc
vim.api.nvim_set_keymap("t", "<Esc>", "<C-\\><C-n>", { nowait = true })

-- A bunch of useful shortcuts for one-time small actions bound on leader
vim.api.nvim_set_keymap("n", "<leader>n", "<cmd>nohlsearch<CR>", { silent = true })

--  Pull one line down useful rempaps from the numeric line
vim.keymap.set("n", "<C-t>", "%", { remap = true })

-------------------------------------------------------------------------------
--                           Folding section
-------------------------------------------------------------------------------

-- Use <CR> to fold when in normal mode
-- To see help about folds use `:help fold`
vim.keymap.set("n", "<CR>", function()
  -- Get the current line number
  local line = vim.fn.line "."
  -- Get the fold level of the current line
  local foldlevel = vim.fn.foldlevel(line)
  -- vim.notify("Fold level: " .. foldlevel, vim.log.levels.INFO)
  if foldlevel == 0 then
    vim.notify("No fold found", vim.log.levels.INFO)
  else
    vim.notify("Fold found", vim.log.levels.INFO)
    vim.cmd "normal! za"
  end
end, { desc = "[P]Toggle fold" })

local function set_foldmethod_expr()
  vim.notify("Setting foldmethod to expr", vim.log.levels.INFO)
  -- These are lazyvim.org defaults but setting them just in case a file
  -- doesn't have them set
  if vim.fn.has "nvim-0.10" == 1 then
    vim.notify("Setting foldmethod to expr", vim.log.levels.INFO)
    vim.opt.foldmethod = "expr"
    vim.opt.foldexpr = "v:lua.require'lazyvim.util'.ui.foldexpr()"
    vim.opt.foldtext = ""
  else
    vim.opt.foldmethod = "indent"
    vim.notify("Setting foldmethod to indent", vim.log.levels.INFO)
    vim.opt.foldtext = "v:lua.require'lazyvim.util'.ui.foldtext()"
  end
  vim.opt.foldlevel = 99
end

-- Function to fold all headings of a specific level
local function fold_headings_of_level(level)
  -- vim.notify("Folding level " .. level, vim.log.levels.INFO)
  -- Move to the top of the file
  vim.cmd "normal! gg"
  -- Get the total number of lines:
  local total_lines = vim.fn.line "$"
  for line = 1, total_lines do
    -- Get the content of the current line
    local line_content = vim.fn.getline(line)
    -- "^" -> Ensures the match is at the start of the line
    -- string.rep("#", level) -> Creates a string with 'level' number of "#" characters
    -- "%s" -> Matches any whitespace character after the "#" characters
    -- So this will match `## `, `### `, `#### ` for example, which are markdown headings
    if line_content:match("^" .. string.rep("#", level) .. "%s") then
      -- Move the cursor to the current line
      vim.fn.cursor(line, 1)
      -- Fold the heading if it matches the level
      if vim.fn.foldclosed(line) == -1 then
        vim.cmd "normal! za"
      end
    end
  end
end

local function fold_markdown_headings(levels)
  vim.notify("Folding markdown headings", vim.log.levels.INFO)
  set_foldmethod_expr()
  -- I save the view to know where to jump back after folding
  local saved_view = vim.fn.winsaveview()
  for _, level in ipairs(levels) do
    vim.notify("Folding level " .. level, vim.log.levels.INFO)
    fold_headings_of_level(level)
  end
  vim.cmd "nohlsearch"
  -- Restore the view to jump to where I was
  vim.fn.winrestview(saved_view)
end

-- Keymap for unfolding markdown headings of level 2 or above
-- Changed all the markdown folding and unfolding keymaps from <leader>mfj to
-- zj, zk, zl, z; and zu respectively lamw25wmal
vim.keymap.set("n", "zu", function()
  -- vim.keymap.set("n", "<leader>mfu", function()
  -- Reloads the file to reflect the changes
  vim.cmd "edit!"
  vim.cmd "normal! zR" -- Unfold all headings
end, { desc = "[P]Unfold all headings level 2 or above" })

-- Keymap for folding markdown headings of level 1 or above
vim.keymap.set("n", "zj", function()
  -- vim.keymap.set("n", "<leader>mfj", function()
  -- Reloads the file to refresh folds, otherwise you have to re-open neovim
  vim.cmd "edit!"
  -- Unfold everything first or I had issues
  vim.cmd "normal! zR"
  fold_markdown_headings { 6, 5, 4, 3, 2, 1 }
end, { desc = "[P]Fold all headings level 1 or above" })

-- Keymap for folding markdown headings of level 2 or above
-- I know, it reads like "madafaka" but "k" for me means "2"
vim.keymap.set("n", "zk", function()
  -- vim.keymap.set("n", "<leader>mfk", function()
  -- Reloads the file to refresh folds, otherwise you have to re-open neovim
  vim.cmd "edit!"
  -- Unfold everything first or I had issues
  vim.cmd "normal! zR"
  fold_markdown_headings { 6, 5, 4, 3, 2 }
end, { desc = "[P]Fold all headings level 2 or above" })

-- Keymap for folding markdown headings of level 3 or above
vim.keymap.set("n", "zl", function()
  -- vim.keymap.set("n", "<leader>mfl", function()
  -- Reloads the file to refresh folds, otherwise you have to re-open neovim
  vim.cmd "edit!"
  -- Unfold everything first or I had issues
  vim.cmd "normal! zR"
  fold_markdown_headings { 6, 5, 4, 3 }
end, { desc = "[P]Fold all headings level 3 or above" })

-- Keymap for folding markdown headings of level 4 or above
vim.keymap.set("n", "z;", function()
  -- vim.keymap.set("n", "<leader>mf;", function()
  -- Reloads the file to refresh folds, otherwise you have to re-open neovim
  vim.cmd "edit!"
  -- Unfold everything first or I had issues
  vim.cmd "normal! zR"
  fold_markdown_headings { 6, 5, 4 }
end, { desc = "[P]Fold all headings level 4 or above" })

-------------------------------------------------------------------------------
--                         End Folding section
-------------------------------------------------------------------------------

local function open_file_under_cursor_in_the_panel_above()
  local telescope = require "telescope.builtin"

  local filename = vim.fn.expand "<cfile>"
  local full_path_with_suffix = vim.fn.expand "<cWORD>"

  vim.api.nvim_command "wincmd k"

  if vim.loop.fs_stat(filename) then
    vim.api.nvim_command(string.format("e %s", full_path_with_suffix))
  elseif telescope then
    telescope.find_files {
      prompt_prefix = "🪿 ",
      default_text = full_path_with_suffix,
      wrap_results = true,
      find_command = { "rg", "--files", "--no-require-git" },
    }
  else
    error(string.format("File %s does not exist", filename))
  end
end

-- Opens file under cursor in the panel above
vim.keymap.set("n", "gf", open_file_under_cursor_in_the_panel_above, { silent = true })

-- Set of commands that should be executed on startup
vim.cmd [[command! -nargs=1 Browse silent lua vim.fn.system('open ' .. vim.fn.shellescape(<q-args>, 1))]]
vim.cmd [[highlight DiagnosticUnderlineError cterm=undercurl gui=undercurl guisp=#f87171]]

-- Simulate netrw gx without netrw
-- Map 'gx' to open the file or URL under cursor
vim.keymap.set("n", "gx", function()
  local target = vim.fn.expand "<cfile>"
  vim.fn.system(string.format("open '%s'", target))
end, { silent = false })

require("refactoring-macro").setupMacro()

if os.getenv "PRESENTATION" then
  vim.cmd "LspStop"
  vim.o.relativenumber = false
  vim.o.cursorline = false
end
