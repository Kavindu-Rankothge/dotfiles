set syntax=on
set filetype=on

" Convert tabs to space and use 2 spaces
set autoindent
set tabstop=2
set shiftwidth=2
set expandtab
set softtabstop=2
set smarttab

" Turn off mouse
set mouse=

" Press F2 to hide numbers column
set number
set relativenumber
nnoremap <F2> :set number!<CR>:set relativenumber!<CR> 

" Tree explorer
let g:netrw_banner = 0
inoremap <c-e> <Esc>:Lex<cr>:vertical resize 30<cr>
nnoremap <c-e> <Esc>:Lex<cr>:vertical resize 30<cr>

" Set current working directory for find files
set path=.,**
