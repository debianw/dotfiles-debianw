local options = {
  fileencoding = "utf-8",
  completeopt = { "menuone", "noselect" },
  mouse = 'a',
  hidden = true,
  errorbells = false,
  tabstop = 2,
  softtabstop = 2,
  shiftwidth = 2,
  expandtab = true,
  smartindent = true,
  autoindent = true,
  number = true,
  hlsearch = false,
  wrap = false,
  smartcase = true,
  ignorecase = true,
  swapfile = false,
  backup = false,
  undodir = "~/.nvim/undodir",
  undofile = true,
  incsearch = true,
  relativenumber = true,
  scrolloff = 8,
  background = "dark",
  colorcolumn = "100",
  signcolumn = "yes",
  splitright = true,
  splitbelow = true,
  clipboard = "unnamedplus",
  cursorline = true,
  termguicolors = true,
}

for k, v in pairs(options) do
    vim.opt[k] = v
end

-- vim.cmd "highlight ColorColumn ctermbg=0 guibg=lightgrey"
vim.cmd "highlight ColorColumn ctermbg=0 guibg=#839496"
