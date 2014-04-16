set nocompatible
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

syntax enable
syntax on
set hlsearch
set expandtab
set showmatch
set incsearch
set nobackup
set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent
set cindent
set smartindent
filetype plugin on
filetype plugin indent on
set nu
set mouse=a
set showcmd
set nowrap
colorscheme desert

autocmd Filetype python nmap <F5> <Esc>:w<CR> :!python %<CR>
autocmd Filetype html nmap <F5> <Esc>:w<CR> :!chrome %:p<CR>
	
nmap <F5> <Esc>:!python %<CR>

map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1

nnoremap <silent> <F3> :Grep<CR>
inoremap {<CR> {}<ESC>i<CR><ESC>O

set tags=tags
set autochdir

let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1

filetype plugin indent on
set completeopt=longest,menu
set wildmenu

set guioptions-=T
set cul
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
set laststatus=2
