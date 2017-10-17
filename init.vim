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

" mksession options
set sessionoptions=buffers

" ---- Plugins ---- "
call plug#begin('~/.local/share/nvim/plugged')

Plug 'airblade/vim-gitgutter'
Plug 'ap/vim-css-color'
Plug 'bling/vim-bufferline'
Plug 'brookhong/cscope.vim'
Plug 'dbgx/lldb.nvim'
Plug 'derekwyatt/vim-fswitch'
Plug 'dhruvasagar/vim-table-mode'
Plug 'garbas/vim-snipmate'
Plug 'godlygeek/tabular'
Plug 'honza/vim-snippets'
Plug 'kien/ctrlp.vim'
Plug 'kshenoy/vim-signature'
Plug 'ludovicchabant/vim-gutentags'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'majutsushi/tagbar'
Plug 'mileszs/ack.vim'
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
Plug 'tpope/vim-sensible'
Plug 'Valloric/ListToggle'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'zchee/deoplete-clang'

call plug#end()

call deoplete#enable()
let g:deoplete#sources#clang#libclang_path="/usr/lib/libclang.so"
let g:deoplete#sources#clang#clang_header="/usr/lib/clang/"

colorscheme gruvbox

" current line highlight
set cursorline
highlight CursorLine ctermbg=black ctermfg=None

" ending column highlight
set colorcolumn=101
highlight ColorColumn ctermbg=167

""" Mappings "

" extra windows
nnoremap <F2> :NERDTreeToggle<CR>
nnoremap <F3> :GundoToggle<CR>
nnoremap <F4> :Tagbar<CR>

nnoremap gc :cd %:p:h<CR>:pwd<CR>
map <leader>w :FSHere<CR>
map <leader>t :call Toggle_task_status()<CR>
map <leader>s :S/
tnoremap <Esc> <C-\><C-n>

" tab navigation
nnoremap <silent> [d :tabprevious<CR>
nnoremap <silent> ]d :tabnext<CR>
nnoremap <silent> [D :tabfirst<CR>
nnoremap <silent> ]D :tablast<CR>

" ack.vim use silver searcher
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" lldb.vim navigation
nnoremap <leader>db <Plug>LLBreakSwitch<CR>
nnoremap <leader>dn :LL next<CR>
nnoremap <leader>dc :LL continue<CR>
nnoremap <leader>di :LL stepi<CR>
nnoremap <leader>du :LL up<CR>

" cscove shortcuts
nnoremap <leader>fa :call CscopeFindInteractive(expand('<cword>'))<CR>
" find symbol
nnoremap <leader>fs :call CscopeFind('s', expand('<cword>'))<CR>
" find definition
nnoremap <leader>fg :call CscopeFind('g', expand('<cword>'))<CR>
" find functions called by this function
nnoremap <leader>fd :call CscopeFind('d', expand('<cword>'))<CR>
" find functions calling this function
nnoremap <leader>fc :call CscopeFind('c', expand('<cword>'))<CR>
" find this text string
nnoremap <leader>ft :call CscopeFind('t', expand('<cword>'))<CR>
" find this egrep pattern
nnoremap <leader>fe :call CscopeFind('e', expand('<cword>'))<CR>
" find this file
nnoremap <leader>ff :call CscopeFind('f', expand('<cword>'))<CR>
" find files #including this file
nnoremap <leader>fi :call CscopeFind('i', expand('<cword>'))<CR>

"nnoremap <leader>\cI :call NERDComInsertComment<CR>

let g:cscope_silent=1

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
let g:airline_section_c = '%t'

""" UltiSnips configuration """
let g:UltiSnipsSnippetsDir="~/.config/nvim/UltiSnips"
let g:UltiSnipsExpandTrigger="<C-j>"
let g:UltiSnipsEnableSnipMate=0

""" Signature colorize """
highlight SignatureMarkText ctermfg=205
highlight Whitespace ctermfg=167
highlight NonText ctermfg=239
set list

" --- Neomake --- "
let g:neomake_cpp_enabled_makers = ['clangtidy']
let g:neomake_cpp_clangtidy_maker = {
   \ 'exe': '/usr/bin/clang-tidy',
   \ 'args': ['-checks=*', '-p build' ],
   \}
