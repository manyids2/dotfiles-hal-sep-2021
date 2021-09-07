local install_path = os.getenv('HOME') .. '/.local/share/nvim/site/pack/packer/opt/packer.nvim'

-- Packer.nvim bootstraping strategy
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  local plugin_repo = 'https://github.com/wbthomason/packer.nvim'
  local cli = string.format('!git clone %s %s', plugin_repo, install_path)
  vim.cmd(cli)
end

vim.cmd 'packadd packer.nvim'
local packer = require 'packer'

packer.init {
  package_root = os.getenv('HOME') .. '/.local/share/nvim/site/pack',
  compile_path = os.getenv('HOME') .. '/.config/nvim/plugin/packer_compiled.vim'
}

-- For plugins that use g: as config
-- require 'x.plugins.config'.init()

-- Load plugins
packer.startup(function(use)
  use { 'wbthomason/packer.nvim', opt = true }

  -- Deps
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'
  use { 'hrsh7th/nvim-compe' }

  -- Essentials
  use 'tpope/vim-commentary'
  use 'tpope/vim-surround'
  use 'tpope/vim-repeat'
  use 'vim-scripts/ReplaceWithRegister'
  use 'nelstrom/vim-visual-star-search'

  -- Editor
  use 'SirVer/ultisnips'
  use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim' } }
  use 'mcchrish/nnn.vim'

  -- LSP
  use 'neovim/nvim-lspconfig'
  use 'nvim-lua/lsp-status.nvim'
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use {
    "kkoomen/vim-doge",
    run = ':call doge#install()',
    config = function()
        vim.g.doge_doc_standard_python = 'numpy'
    end
  }

  -- Themes
  use 'ryanoasis/vim-devicons'
  use 'marko-cerovac/material.nvim'
  use 'rafamadriz/neon'
  use 'tomasiser/vim-code-dark'

  -- IDE
  use 'tmhedberg/SimpylFold'
  use 'masukomi/vim-markdown-folding'
  use 'glepnir/dashboard-nvim'
  use 'lukas-reineke/format.nvim'
  use 'rafamadriz/friendly-snippets'
  use 'mattn/emmet-vim'
  use 'hrsh7th/vim-vsnip'
  use 'hrsh7th/vim-vsnip-integ'
  use 'junegunn/fzf'
  use 'alok/notational-fzf-vim'
  use {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup {
        vim.cmd("set timeoutlen=500");
      }
    end
  }

  -- For Development
  -- use '~/projects/github.com/x/projectcmd.nvim'
end)

-- For plugins that use setup() as config
-- require 'x.plugins.config'.setup()
