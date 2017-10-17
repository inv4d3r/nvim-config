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
packadd minpac
call minpac#init()

call minpac#add('airblade/vim-gitgutter')
call minpac#add('ap/vim-css-color')
call minpac#add('bling/vim-bufferline')
call minpac#add('brookhong/cscope.vim')
call minpac#add('dbgx/lldb.nvim')
call minpac#add('derekwyatt/vim-fswitch')
call minpac#add('dhruvasagar/vim-table-mode')
call minpac#add('garbas/vim-snipmate')
call minpac#add('godlygeek/tabular')
call minpac#add('honza/vim-snippets')
call minpac#add('k-takata/minpac', { 'type' : 'opt' })
call minpac#add('kien/ctrlp.vim')
call minpac#add('kshenoy/vim-signature')
call minpac#add('ludovicchabant/vim-gutentags')
call minpac#add('MarcWeber/vim-addon-mw-utils')
call minpac#add('majutsushi/tagbar')
call minpac#add('mileszs/ack.vim')
call minpac#add('morhetz/gruvbox')
call minpac#add('neomake/neomake')
call minpac#add('Raimondi/delimitMate')
call minpac#add('samsonw/vim-task')
call minpac#add('scrooloose/nerdcommenter')
call minpac#add('scrooloose/nerdtree')
call minpac#add('Shougo/deoplete.nvim')
call minpac#add('Shougo/neoinclude.vim')
call minpac#add('sirver/UltiSnips')
call minpac#add('sjl/gundo.vim')
call minpac#add('tommcdo/vim-exchange')
call minpac#add('tomtom/tlib_vim')
call minpac#add('tpope/tpope-vim-abolish')
call minpac#add('tpope/vim-endwise')
call minpac#add('tpope/vim-fugitive')
call minpac#add('tpope/vim-repeat')
call minpac#add('tpope/vim-sleuth')
call minpac#add('tpope/vim-surround')
call minpac#add('tpope/vim-unimpaired')
call minpac#add('tpope/vim-sensible')
call minpac#add('Valloric/ListToggle')
call minpac#add('vim-airline/vim-airline')
call minpac#add('vim-airline/vim-airline-themes')
call minpac#add('zchee/deoplete-clang')

let g:deoplete#enable_at_startup = 1
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
