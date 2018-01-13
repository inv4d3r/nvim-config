" ---- Defaults ---- "

" line numbers
set number
set relativenumber

" do not wrap overflowing characters, it's annoying
set nowrap

" vim won't force to write changed buffer
set hidden

" show current normal command in status line
set showcmd

" adjust colors for dark background
set background=dark

" highlight search matches
set hlsearch

" mksession options
set sessionoptions=buffers

" show whitespace
set listchars=tab:  
set list

" horizontal line
set cursorline

" comply with Linux kernel coding style "
set colorcolumn=101

" ---- Highlighting ---- "

" current line highlight
highlight CursorLine ctermbg=black ctermfg=None

" max column highlight
highlight ColorColumn ctermbg=167

" signature colorize "
highlight SignatureMarkText ctermfg=205
highlight Whitespace ctermfg=167
highlight NonText ctermfg=239

" trailing whitespace
highlight ExtraWhitespace ctermbg=red
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()


" ---- Mappings ---- "

" go to current file's path
nnoremap gc :cd %:p:h<CR>:pwd<CR>

" terminal - go to normal mode
tnoremap <Esc> <C-\><C-n>

" tab navigation
nnoremap <silent> [d :tabprevious<CR>
nnoremap <silent> ]d :tabnext<CR>
nnoremap <silent> [D :tabfirst<CR>
nnoremap <silent> ]D :tablast<CR>

" ---- Plugins ---- "

packadd minpac
call minpac#init()

call minpac#add('airblade/vim-gitgutter')
call minpac#add('ap/vim-css-color')
call minpac#add('arcticicestudio/nord-vim')
call minpac#add('brookhong/cscope.vim')
call minpac#add('derekwyatt/vim-fswitch')
call minpac#add('dracula/vim')
call minpac#add('godlygeek/tabular')
call minpac#add('junegunn/fzf', { 'do' : './install --all' })
call minpac#add('junegunn/fzf.vim')
call minpac#add('k-takata/minpac', { 'type' : 'opt' })
call minpac#add('kshenoy/vim-signature')
call minpac#add('ludovicchabant/vim-gutentags')
call minpac#add('majutsushi/tagbar')
call minpac#add('milkypostman/vim-togglelist')
call minpac#add('morhetz/gruvbox')
call minpac#add('sjl/badwolf')
call minpac#add('scrooloose/nerdcommenter')
call minpac#add('scrooloose/nerdtree')
call minpac#add('Shougo/deoplete.nvim')
call minpac#add('Shougo/neoinclude.vim')
call minpac#add('sirver/UltiSnips')
call minpac#add('sjl/gundo.vim')
call minpac#add('tommcdo/vim-exchange')
call minpac#add('tpope/tpope-vim-abolish')
call minpac#add('tpope/vim-endwise')
call minpac#add('tpope/vim-fugitive')
call minpac#add('tpope/vim-repeat')
call minpac#add('tpope/vim-surround')
call minpac#add('tpope/vim-unimpaired')
call minpac#add('tpope/vim-sleuth')
call minpac#add('vim-airline/vim-airline')
call minpac#add('vim-airline/vim-airline-themes')
call minpac#add('w0rp/ale')
call minpac#add('zchee/deoplete-clang')

" colorscheme
if $THEME == ""
   let scheme_name = 'default'
   let airline_scheme_name = 'base16_grayscale'
else
   let scheme_name = $THEME
   let airline_scheme_name = $THEME
endif
execute 'colorscheme' scheme_name

" ---- extra windows ---- "
nnoremap <F2> :NERDTreeToggle<CR>
nnoremap <F3> :GundoToggle<CR>
nnoremap <F4> :Tagbar<CR>

" ---- airline configuration ---- "
let g:airline_theme             = airline_scheme_name
let g:airline#extensions#branch#enabled = 2
let g:airline#extensions#syntastic#enabled = 1
let g:airline_left_sep          = ''
let g:airline_left_alt_sep      = ''
let g:airline_right_sep         = ''
let g:airline_right_alt_sep     = ''
let g:airline_section_c = '%t'

" ---- cscove configuration ---- "
let g:cscope_silent=1

" legend: s - symbol, g - definition,
"         d - functions called by this function,
"         c - functions calling this function,
"         t - text string, e - egrep pattern,
"         f - file, i - files #including this file
nnoremap <leader>fs :call CscopeFind('s', expand('<cword>'))<CR>
nnoremap <leader>fg :call CscopeFind('g', expand('<cword>'))<CR>
nnoremap <leader>fd :call CscopeFind('d', expand('<cword>'))<CR>
nnoremap <leader>fc :call CscopeFind('c', expand('<cword>'))<CR>
nnoremap <leader>ft :call CscopeFind('t', expand('<cword>'))<CR>
nnoremap <leader>fe :call CscopeFind('e', expand('<cword>'))<CR>
nnoremap <leader>ff :call CscopeFind('f', expand('<cword>'))<CR>
nnoremap <leader>fi :call CscopeFind('i', expand('<cword>'))<CR>

" find any object manually typed
command! -nargs=+ CscoveFind call CscopeFind(<f-args>)
nnoremap <leader>fm :CscoveFind 

" ---- deoplete config ---- "
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#clang#libclang_path="/usr/lib/libclang.so"
let g:deoplete#sources#clang#clang_header="/usr/lib/clang/"

" close preview window when leaving insert mode
autocmd InsertLeave * if pumvisible() == 0 | pclose | endif

" ---- switch to header/source ---- "
map <leader>w :FSHere<CR>

" ---- fzf config ---- "
let g:fzf_command_prefix = "Fzf"
nnoremap <leader>za :FzfAg<CR>
nnoremap <leader>zb :FzfBuffers<CR>
nnoremap <leader>zc :FzfCommits<CR>
nnoremap <leader>zd :FzfBCommits<CR>
nnoremap <leader>ze :FzfCommands<CR>
nnoremap <leader>zf :FzfFiles<CR>
nnoremap <leader>zg :FzfGFiles<CR>
nnoremap <leader>zh :FzfGFiles?<CR>
nnoremap <leader>zm :FzfMarks<CR>
nnoremap <leader>zs :FzfSnippets<CR>
nnoremap <leader>zt :FzfTags<CR>
nnoremap <leader>zu :FzfBTags<CR>

" ---- latex configuration ---- "
let g:tex_flavor = "latex"

" ---- NERDCommenter configuration ---- "
let g:NERDCompactSexyComs = 1
let g:NERDTrimTrailingWhitespace = 1

" ---- NERDTree configuration ---- "
let g:NERDTreeShowLineNumbers=1
autocmd BufEnter NERD_* setlocal rnu

" ---- Substitute configuration ---- "
map <leader>s :S/

" ---- UltiSnips configuration ---- "
let g:UltiSnipsSnippetsDir="~/.config/nvim/UltiSnips"
let g:UltiSnipsExpandTrigger="<C-j>"
let g:UltiSnipsEnableSnipMate=0
