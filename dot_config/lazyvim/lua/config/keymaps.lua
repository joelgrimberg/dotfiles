-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- -- Set all the overrides and the extensions for the things that are available in native vim
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
-- vim.api.nvim_set_keymap("n", "<D-A-v>", "<C-w>v<C-w>w", { silent = true })
-- vim.api.nvim_set_keymap("n", "<D-A-s>", "<C-w>s<C-w>j", { silent = true })
-- vim.api.nvim_set_keymap("n", "<D-A-l>", "<C-w>l", { silent = true })
-- vim.api.nvim_set_keymap("n", "<D-A-h>", "<C-w>h", { silent = true })
-- vim.api.nvim_set_keymap("n", "<D-A-q>", "<C-w>q", { silent = true })
-- vim.api.nvim_set_keymap("n", "<D-A-j>", "<C-w>j", { silent = true })
-- vim.api.nvim_set_keymap("n", "<D-A-k>", "<C-w>k", { silent = true })
--
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
