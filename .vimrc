let s:bundle_dir = expand('$HOME/.vim/bundle')
let s:neobundle_dir = s:bundle_dir . '/neobundle.vim'
let s:neobundle_repo = 'https://github.com/Shougo/neobundle.vim'
let g:neobundle#cache_file = expand('$HOME/.vim/neobundlecache')
let &runtimepath.=','.s:neobundle_dir
try
	call neobundle#begin(s:bundle_dir)
catch /E117/ " neobundle not installed
	execute "!mkdir -p " .  s:neobundle_dir
	execute "!" . "git clone " s:neobundle_repo . " " . s:neobundle_dir
	call neobundle#begin(s:bundle_dir)
	NeoBundleInstall
	call neobundle#end()
	quit
endtry



" Bundles
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'sgur/ctrlp-extensions.vim'
NeoBundle 'tpope/vim-surround'
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'SirVer/ultisnips'
NeoBundle 'Yggdroot/indentLine'

call neobundle#end()
filetype plugin indent on
NeoBundleCheck

" Colors
" let g:base16_shell_path=$HOME . '/bin/base16-shell/scripts'
set t_Co=256
let base16colorspace=256
set background=dark
colorscheme base16-default-dark
set cursorline
hi CursorLine term=bold cterm=bold guibg=Grey40

" Syntax Highlighting
syntax on
set number

filetype plugin on
set omnifunc=syntaxcomplete#Complete
set encoding=utf-8
set pastetoggle=<F2>

set mouse=a
set bs=2

let mapleader = ","
nmap s <Plug>(easymotion-sl)
nmap S <Plug>(easymotion-s)

" Remove last highlights
highlight Cursor guifg=green guibg=red

" Use Spaces
set tabstop=2
set softtabstop=2
set shiftwidth=2
set shiftround
set expandtab

" Make search case insensitive
set hlsearch
set incsearch
set ignorecase
set smartcase

" Disable tmp files
set nobackup
set nowritebackup

" ctrlp settings
let g:ctrlp_max_height = 30
set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=*/coverage/*

" disable folding
set nofoldenable

" Ultisnip config
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" enable W to write as root
command W w !sudo tee % > /dev/null

highlight! link CurSearch IncSearch
"function! HighlightCurrentMatch()
"    let col = col(".") - 1
"    let endCol = searchpos(getreg("/"), "cne")[1] + 1
"    let line = line(".")
"    let matchPat = '/\%' . line . 'l\%>' . col . 'c\%<' . endCol . 'c/'
"    echomsg matchPat
"    3match none
"    exe ':3match CurSearch ' . matchPat
"endfunction

"nnoremap n n:silent! call HighlightCurrentMatch()<CR>
"nnoremap N N:silent! call HighlightCurrentMatch()<CR>
map <C-N> :set hls!<bar> set hls?<CR>

" Filebin
com -range=% Fb :exec "<line1>,<line2>w !fb -e ".&filetype." -n ".expand("%:t")
let g:indentLine_char = '┆'

map <F7> <Esc>I<a href="<Esc>A"><Esc>gJA</a><Esc>
