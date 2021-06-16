local ts = require 'nvim-treesitter.configs'
ts.setup {ensure_installed = 'maintained', highlight = {enable = true}}


-- Convenience method to set both global and scoped option
-- Can be removed once available in root neovim
local scopes = {o = vim.o, b = vim.bo, w = vim.wo}
local function opt(scope, key, value)
  scopes[scope][key] = value
  if scope ~= 'o' then scopes['o'][key] = value end
end


vim.o.termguicolors = true
vim.o.background = 'dark'
vim.g['nvim_tree_ignore'] = {'.git', 'node_modules', '.cache', '*.unity', '*.meta'}

require('material').set()
vim.g.material_style = "palenight"
vim.g.material_italic_comments = true
vim.g.material_contrast = true


opt('b', 'shiftwidth', 4)
opt('b', 'tabstop', 4)
opt('b', 'expandtab', true)
opt('w', 'signcolumn', 'yes')
opt('w', 'number', true)
opt('w', 'relativenumber', true)

vim.o.smarttab = true
vim.o.smartcase = true
vim.o.hidden = true
