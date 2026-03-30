syntax on

colorscheme sorbet

 if &diff
     colorscheme habamax
 endif

nnoremap <leader>c :let @/='\<' . expand('<cword>') . '\>'<CR>:echo searchcount().total . " matches"<CR>
nnoremap <C-c> :w !wl-copy<CR><CR>

vnoremap <C-c> :w !wl-copy<CR><CR>

set laststatus=2
set ignorecase
set smartcase
set backupcopy=yes
