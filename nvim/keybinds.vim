" Keyboard mappings to make life sane
let mapleader = " "
set timeoutlen=200

nmap s <Plug>(easymotion-overwin-f2)
nnoremap <Leader><Tab> :NERDTreeToggle<CR>
nnoremap <Leader><Leader>l <C-W><C-L>
nnoremap <Leader><Leader>h <C-W><C-H>
nnoremap <Leader><Leader>j <C-W><C-J>
nnoremap <Leader><Leader>k <C-W><C-K>
nnoremap <Leader>l :bnext<CR>
nnoremap <Leader>h :bprev<CR>
nnoremap <Leader>c :Bdelete<CR>
nnoremap <Leader>p :FZF<CR>

