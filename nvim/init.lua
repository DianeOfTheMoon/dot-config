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


vim.g['nvim_tree_ignore'] = { '.git', 'node_modules', '.cache' }
vim.g['nvim_tree_auto_close'] = 1

require('lsp')
require('keybinds')
require('display')



return require('packer').startup(function()
	use 'drewtempelmeyer/palenight.vim'
    use 'neovim/nvim-lspconfig'
    use 'nvim-treesitter/nvim-treesitter'
    use 'glepnir/zephyr-nvim'
    use 'justinmk/vim-sneak'
    use 'liuchengxu/vista.vim'
    use 'romgrk/barbar.nvim'
    use 'tjdevries/colorbuddy.nvim'
    use 'kyazdani42/nvim-web-devicons'
    use 'kyazdani42/nvim-tree.lua'
    use {
        'glepnir/galaxyline.nvim',
        branch = 'main',
        config = function() require('config_statusline') end,
        requires = {'kyazdani42/nvim-web-devicons', opt = true}
    }
    use {
    'ojroques/nvim-lspfuzzy',
    requires = {
      {'junegunn/fzf'},
      {'junegunn/fzf.vim'},  -- to enable preview (optional)
    },
  }
end)

