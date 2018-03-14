"
"   FILE: ~/.vimrc
" AUTHOR: Zubair Khan
"  DESCR: VIM configuration file
"

" Set mapleader
let mapleader=","

" Use vim settings rather than vi settings.
set nocompatible

" Make backspace behave in a sane manner.
set backspace=indent,eol,start

" Switch syntax highlighting on.
syntax on

" Enable search highlighting and autoindent
set hlsearch autoindent smartindent

" To prevent plugins from autofolding the code
set nofoldenable

" Enable file type detection and do language-dependent indenting.
filetype plugin indent on

" Set the default file encoding to UTF-8: 
"set encoding=utf-8

" Insert new line without going into insert mode
map <S-Enter> O<Esc>
map <CR> o<Esc>

" Moving between split windows using control-<movement>
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" Automatically add closing brace
"inoremap { {<CR>}<Esc>ko

" Go to the first non-whitespace character in a line
imap <C-0> ^

set tabstop=4
set shiftwidth=4
set expandtab

" Useful for copy pasting from clipboard
set pastetoggle=<c-p>

" Change cursor shape in normal/insert mode


execute pathogen#infect()
