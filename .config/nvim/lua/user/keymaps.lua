local opts = { noremap = true, silent = true }
local term_opts = { silent = true }
local keymap = vim.api.nvim_set_keymap

-- Leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
-- normal_mode = "n"
-- insert_mode = "i"
-- visual_mode = "v"
-- visual_block_mode = "x"
-- term_mode = "t"
-- command_mode = "c"

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-S-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-S-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-S-Right>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-S-Left>", ":vertical resize +2<CR>", opts)
keymap("n", "<C-c>", ":q<CR>", opts)


-- NERDTree
keymap("n", "<leader>e", ":NERDTreeFind<CR>", opts)
keymap("n", "<leader>nn", ":NERDTreeToggle<CR>", opts)
-- keymap("n", "<leader>ef", ":NERDTreeFocus<CR>", opts)

-- Telescope
vim.cmd "nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>"
vim.cmd "nnoremap <leader>ft <cmd>lua require('telescope.builtin').git_files()<cr>"
vim.cmd "nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>"
vim.cmd "nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>"
vim.cmd "nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>"
