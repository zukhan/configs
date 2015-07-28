"
"   FILE: ~/.vimrc
" AUTHOR: Zubair Khan
"  DESCR: VIM configuration file
"

" Set mapleader
let mapleader=","

" Imports:
source ~/.vim/plugins/python.vim

" Load Pathogen
filetype off
execute pathogen#infect()

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
inoremap { {<CR>}<Esc>ko

" Go to the first non-whitespace character in a line
imap <C-0> ^

set tabstop=4
set shiftwidth=4
set expandtab

" Useful for copy pasting from clipboard
set pastetoggle=<c-p>

" Mapping for various plugins
nnoremap <c-t> :NERDTree<CR>
nnoremap <c-f> :GundoToggle<CR>


" (BEGIN) This will quit vim if nerdtree is the only buffer left
autocmd WinEnter * call s:CloseIfOnlyNerdTreeLeft()

" Close all open buffers on entering a window if the only
" buffer that's left is the NERDTree buffer
function! s:CloseIfOnlyNerdTreeLeft()
  if exists("t:NERDTreeBufName")
    if bufwinnr(t:NERDTreeBufName) != -1
      if winnr("$") == 1
        q
      endif
    endif
  endif
endfunction

autocmd WinEnter * call s:CloseIfOnlyNerdTreeLeft()
" (END)
