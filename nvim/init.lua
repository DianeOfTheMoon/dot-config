local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
  execute 'packadd packer.nvim'
end

vim.cmd [[packadd packer.nvim]]



vim.g['sneak#label'] = 1
vim.g['sneak#target_labels'] = ';asonetuhidyf'
vim.cmd('set clipboard+=unnamedplus')
vim.cmd('set autoindent smartindent')


vim.g['nvim_tree_ignore'] = { '.git', 'node_modules', '.cache', '.meta', '.csproj', '.sln' }
vim.g['nvim_tree_auto_close'] = 1

require('lsp')
require('keybinds')
require('display')


return require('packer').startup(function()
    use 'christianchiarulli/nvcode-color-schemes.vim'
    use 'neovim/nvim-lspconfig'
    use 'nvim-treesitter/nvim-treesitter'
    use 'marko-cerovac/material.nvim'
    use 'liuchengxu/vista.vim'
    use 'romgrk/barbar.nvim'
    use 'kyazdani42/nvim-web-devicons'
    use 'kyazdani42/nvim-tree.lua'
    use 'wellle/targets.vim'
    use 'nvim-lua/lsp-status.nvim'
    use 'mfussenegger/nvim-dap'
    use 'rcarriga/nvim-dap-ui'
    use 'theHamsta/nvim-dap-virtual-text'
    use 'ggandor/lightspeed.nvim'
    use {
      'nvim-telescope/telescope.nvim',
      requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
    }
    use {
      "folke/trouble.nvim",
      requires = "kyazdani42/nvim-web-devicons",
      config = function()
        require("trouble").setup {
          -- your configuration comes here
          -- or leave it empty to use the default settings
          -- refer to the configuration section below
        }
      end
    }
    use {
        'glepnir/galaxyline.nvim',
        branch = 'main',
        config = function() require('config_statusline') end,
        requires = {'kyazdani42/nvim-web-devicons', opt = true}
    }
    use { 'RishabhRD/nvim-lsputils', requires = {{'RishabhRD/popfix'}}}
    use 'hrsh7th/nvim-compe'
    use 'hrsh7th/vim-vsnip'
    use 'hrsh7th/vim-vsnip-integ'
end)

