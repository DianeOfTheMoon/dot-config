local compe = require('compe')
local map = vim.api.nvim_set_keymap
local nnoremap = function(keypress, action) map('n', keypress, action, {noremap = true, silent = true}) end
local inoremap = function(keypress, action) map('i', keypress, action, {noremap = true, silent = true}) end
vim.g.mapleader = ' '


nnoremap('<leader><tab>', ':NvimTreeToggle<CR>')
nnoremap('<leader>c', ':BufferClose<CR>')
nnoremap('<leader>l', ':BufferNext<CR>')
nnoremap('<leader>h', ':BufferPrevious<CR>')
nnoremap('<leader>p', ':Telescope git_files<CR>')
nnoremap('<leader><leader>l', '<C-W><C-L>')
nnoremap('<leader><leader>h', '<C-W><C-H>')
nnoremap('<leader><leader>j', '<C-W><C-J>')
nnoremap('<leader><leader>k', '<C-W><C-K>')
local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

compe.setup({
  enabled = true;
  autocomplete = 'false';
  debug = true;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    --path = true;
    --buffer = true;
    --calc = true;
    nvim_lsp = true;
    nvim_lua = true;
    vsnip = true;
  };
})

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif vim.fn.call("vsnip#available", {1}) == 1 then
    return t "<Plug>(vsnip-expand-or-jump)"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end

_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
    return t "<Plug>(vsnip-jump-prev)"
  else
    return t "<S-Tab>"
  end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.cmd("inoremap <silent><expr> <CR>      compe#confirm('<CR>')")
vim.cmd("inoremap <silent><expr> <C-e>     compe#close('<C-e>')")
vim.cmd("inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })")
vim.cmd("inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })")
vim.o.completeopt = "menuone,noselect"
vim.cmd("set shortmess+=c")
