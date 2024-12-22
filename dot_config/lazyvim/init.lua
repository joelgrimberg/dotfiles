-- bootstrap lazy.nvim, LazyVim and your plugins

vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.kitty_fast_forwarded_modifiers = "super"

vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4

local IS_STREAMING = os.getenv("STREAM") ~= nil
if IS_STREAMING then
  vim.print("Subscribe to my twitter @goose_plus_plus")
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

require("config.lazy")

local function format_and_save()
  vim.cmd("Format")
  vim.cmd("w")
end

vim.keymap.set({ "n", "i" }, "<D-e>", format_and_save, { silent = true, desc = "Save file" })
-------------------------------------------------------------------------------
--                           Folding section
-------------------------------------------------------------------------------

-- Use <CR> to fold when in normal mode
-- To see help about folds use `:help fold`
vim.keymap.set("n", "<CR>", function()
  -- Get the current line number
  local line = vim.fn.line(".")
  -- Get the fold level of the current line
  local foldlevel = vim.fn.foldlevel(line)
  -- vim.notify("Fold level: " .. foldlevel, vim.log.levels.INFO)
  if foldlevel == 0 then
    vim.notify("No fold found", vim.log.levels.INFO)
  else
    vim.notify("Fold found", vim.log.levels.INFO)
    vim.cmd("normal! za")
  end
end, { desc = "[P]Toggle fold" })

local function set_foldmethod_expr()
  vim.notify("Setting foldmethod to expr", vim.log.levels.INFO)
  -- These are lazyvim.org defaults but setting them just in case a file
  -- doesn't have them set
  if vim.fn.has("nvim-0.10") == 1 then
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
  vim.cmd("normal! gg")
  -- Get the total number of lines:
  local total_lines = vim.fn.line("$")
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
        vim.cmd("normal! za")
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
  vim.cmd("nohlsearch")
  -- Restore the view to jump to where I was
  vim.fn.winrestview(saved_view)
end

-- Keymap for unfolding markdown headings of level 2 or above
-- Changed all the markdown folding and unfolding keymaps from <leader>mfj to
-- zj, zk, zl, z; and zu respectively lamw25wmal
vim.keymap.set("n", "zu", function()
  -- vim.keymap.set("n", "<leader>mfu", function()
  -- Reloads the file to reflect the changes
  vim.cmd("edit!")
  vim.cmd("normal! zR") -- Unfold all headings
end, { desc = "[P]Unfold all headings level 2 or above" })

-- Keymap for folding markdown headings of level 1 or above
vim.keymap.set("n", "zj", function()
  -- vim.keymap.set("n", "<leader>mfj", function()
  -- Reloads the file to refresh folds, otherwise you have to re-open neovim
  vim.cmd("edit!")
  -- Unfold everything first or I had issues
  vim.cmd("normal! zR")
  fold_markdown_headings({ 6, 5, 4, 3, 2, 1 })
end, { desc = "[P]Fold all headings level 1 or above" })

-- Keymap for folding markdown headings of level 2 or above
-- I know, it reads like "madafaka" but "k" for me means "2"
vim.keymap.set("n", "zk", function()
  -- vim.keymap.set("n", "<leader>mfk", function()
  -- Reloads the file to refresh folds, otherwise you have to re-open neovim
  vim.cmd("edit!")
  -- Unfold everything first or I had issues
  vim.cmd("normal! zR")
  fold_markdown_headings({ 6, 5, 4, 3, 2 })
end, { desc = "[P]Fold all headings level 2 or above" })

-- Keymap for folding markdown headings of level 3 or above
vim.keymap.set("n", "zl", function()
  -- vim.keymap.set("n", "<leader>mfl", function()
  -- Reloads the file to refresh folds, otherwise you have to re-open neovim
  vim.cmd("edit!")
  -- Unfold everything first or I had issues
  vim.cmd("normal! zR")
  fold_markdown_headings({ 6, 5, 4, 3 })
end, { desc = "[P]Fold all headings level 3 or above" })

-- Keymap for folding markdown headings of level 4 or above
vim.keymap.set("n", "z;", function()
  -- vim.keymap.set("n", "<leader>mf;", function()
  -- Reloads the file to refresh folds, otherwise you have to re-open neovim
  vim.cmd("edit!")
  -- Unfold everything first or I had issues
  vim.cmd("normal! zR")
  fold_markdown_headings({ 6, 5, 4 })
end, { desc = "[P]Fold all headings level 4 or above" })

-------------------------------------------------------------------------------
--                         End Folding section
-------------------------------------------------------------------------------
---
require("conform").setup({
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
})

local function format()
  require("conform").format({
    lsp_fallback = true,
  })
end

vim.keymap.set({ "n", "i" }, "<F12>", format, { desc = "Format", silent = true })
vim.api.nvim_create_user_command("Format", format, { desc = "Format current buffer with LSP" })

vim.api.nvim_create_user_command("Format", function(args)
  local range = nil
  if args.count ~= -1 then
    local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
    range = {
      start = { args.line1, 0 },
      ["end"] = { args.line2, end_line:len() },
    }
  end
  require("conform").format({ async = true, lsp_format = "fallback", range = range })
end, { range = true, desc = "Format current buffer with LSP" })

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

      vim.lsp.buf.execute_command({ command = "jump", arguments = { input } })
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
    vim.cmd("LspRestart")
  end, "Lsp [R]eload")
  lsp_map("<leader>li", function()
    vim.cmd("LspInfo")
  end, "Lsp [R]eload")
  lsp_map("<leader>lh", function()
    local bufFilter = { bufnr }
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled(filter), filter)
  end, "Lsp toggle inlay [h]ints")
end
