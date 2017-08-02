" line numbers
set number
set relativenumber

" do not wrap overflowing characters, it's annoying
"set nowrap

" vim won't force to write changed buffer 
set hidden

" show current normal command in status line
set showcmd

set background=dark

" highlight search matches
set hlsearch

" current line highlight
hi CursorLine ctermbg=black ctermfg=None
set cursorline

" mksession options
set sessionoptions=buffers

" ---- Plugins ---- "
call plug#begin('~/.local/share/nvim/plugged')

Plug 'airblade/vim-gitgutter'
Plug 'bling/vim-bufferline'
Plug 'derekwyatt/vim-fswitch'
Plug 'garbas/vim-snipmate'
Plug 'godlygeek/tabular'
Plug 'kien/ctrlp.vim'
Plug 'kshenoy/vim-signature'
Plug 'ludovicchabant/vim-gutentags'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'majutsushi/tagbar'
Plug 'morhetz/gruvbox'
Plug 'neomake/neomake'
Plug 'Raimondi/delimitMate'
Plug 'samsonw/vim-task'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/neoinclude.vim'
Plug 'sirver/UltiSnips'
Plug 'sjl/gundo.vim'
Plug 'tommcdo/vim-exchange'
Plug 'tomtom/tlib_vim'
Plug 'tpope/tpope-vim-abolish'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'Valloric/ListToggle'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'zchee/deoplete-clang'

call plug#end()

call deoplete#enable()
let g:deoplete#sources#clang#libclang_path="/usr/lib/libclang.so"
let g:deoplete#sources#clang#clang_header="/usr/lib/clang/"

colorscheme gruvbox

""" Mappings "
map gf :e <cfile><cr>
map <F2> :NERDTreeToggle<CR>
map <F3> :GundoToggle<CR>
map <F4> :Tagbar<CR>

map <leader>f :FSHere<CR>

map <leader>t :call Toggle_task_status()<CR>

" easy subverting
map <leader>s :S/

" tabs navigation (breaks unimpaired mappings for tag navigation)
" nmap ]t :tabnext<CR>
" nmap [t :tabprev<CR>

nmap <C-l> :silent nohl\|redraw<CR>

""" NERDTree show line numbers "
let g:NERDTreeShowLineNumbers=1
autocmd BufEnter NERD_* setlocal rnu

autocmd InsertLeave * if pumvisible() == 0 | pclose | endif
autocmd BufWritePost * Neomake!

" ctrlp configuration
let g:ctrlp_cmd = 'CtrlP'

" Latex configuration
let g:tex_flavor = "latex"

""" Airline configuration "
let g:airline_theme             = 'gruvbox'
let g:airline#extensions#branch#enabled = 2
let g:airline#extensions#syntastic#enabled = 1

" vim-powerline symbols
let g:airline_left_sep          = ''
let g:airline_left_alt_sep      = ''
let g:airline_right_sep         = ''
let g:airline_right_alt_sep     = ''
"let g:airline_symbols.branch   = ''
"let g:airline_symbols.readonly = ''
"let g:airline_symbols.linenr   = ''

""" UltiSnips configuration """
let g:UltiSnipsExpandTrigger="<C-j>"

""" Signature colorize """
highlight SignatureMarkText ctermfg=205
