local map = vim.api.nvim_set_keymap
local nnoremap = function(keypress, action) map('n', keypress, action, {noremap = true, silent = true}) end
vim.g.mapleader = ' '

nnoremap('<leader><tab>', ':NvimTreeToggle<CR>')
nnoremap('<leader>c', ':BufferClose<CR>')
nnoremap('<leader>l', ':BufferNext<CR>')
nnoremap('<leader>h', ':BufferPrevious<CR>')
