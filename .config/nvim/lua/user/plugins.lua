local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path
    }
    print "Installing packer close and reopen Neovim..."
    vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
        return require("packer.util").float { border = "rounded" }
    end,
  }
}

-- Install your plugins here
return packer.startup(function(use)
    -- plugins
    use "wbthomason/packer.nvim" -- Have packer manage itself

    -- Colors
    use "EdenEast/nightfox.nvim"
    use 'marko-cerovac/material.nvim'

    -- Telescope
    use {
    "nvim-telescope/telescope.nvim",
    requires = { { 'nvim-lua/plenary.nvim' } }
    }
    use "nvim-lua/popup.nvim"
    use "nvim-telescope/telescope-fzy-native.nvim"

    -- Treesitter
    use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate"
    }

    -- Airline
    use {
      'nvim-lualine/lualine.nvim',
      requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }

    -- Nerdtree
    use "preservim/nerdtree"
    use "ryanoasis/vim-devicons"

    -- Lsp configuration
    use "neovim/nvim-lspconfig"
    use "williamboman/nvim-lsp-installer"
    use "jose-elias-alvarez/null-ls.nvim"
    use "jose-elias-alvarez/nvim-lsp-ts-utils"

    -- Cmp
    use "hrsh7th/cmp-nvim-lsp"
    use "hrsh7th/cmp-buffer"
    use "hrsh7th/cmp-path"
    use "hrsh7th/nvim-cmp"
    use "hrsh7th/cmp-cmdline"
    use "saadparwaiz1/cmp_luasnip"

    -- Snip
    use "hrsh7th/cmp-vsnip" 
    use "hrsh7th/vim-vsnip"
    use "L3MON4D3/LuaSnip"
    use "rafamadriz/friendly-snippets"

    -- Indent blankline
    use "lukas-reineke/indent-blankline.nvim"

    -- Git
    use {
      'lewis6991/gitsigns.nvim',
      requires = {
      'nvim-lua/plenary.nvim'
      },
      -- tag = 'release' -- To use the latest release
    }

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
