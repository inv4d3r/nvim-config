" ---- Defaults ---- "

set foldmethod=syntax
set foldlevelstart=1

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

" always copy to plus register
set clipboard=unnamedplus

" horizontal line
set cursorline

" comply with Linux kernel coding style "
set colorcolumn=81

" ---- Highlighting ---- "

" current line highlight
highlight CursorLine ctermbg=black ctermfg=None guibg=black guifg=None

" max column highlight
highlight ColorColumn ctermbg=167 guibg=167

" signature colorize "
highlight SignatureMarkText ctermfg=205 guifg=205
highlight Whitespace ctermfg=167 guifg=167
highlight NonText ctermfg=239 guifg=239

" trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" cppman for cpp files
autocmd FileType cpp set keywordprg=:term\ cppman


" ---- Mappings ---- "

noremap <Esc> :nohl<CR>

nnoremap <space> <C-^>

" go to current file's path
nnoremap gc :cd %:p:h<CR>:pwd<CR>

" terminal - go to normal mode
tnoremap <Esc> <C-\><C-n>

" tab navigation
nnoremap <silent> [d :tabprevious<CR>
nnoremap <silent> ]d :tabnext<CR>
nnoremap <silent> [D :tabfirst<CR>
nnoremap <silent> ]D :tablast<CR>

" buffer navigation
nnoremap <leader>bd :b <C-D>
nnoremap <leader>bl :ls<CR>:b 
nnoremap <leader>bs :sb <C-D>
nnoremap <leader>bt :ls<CR>:sb 
nnoremap <leader>bv :vert sb <C-D>
nnoremap <leader>bx :ls<CR>:vert sb 

" trailing whitespace mappings
" current buffer
nnoremap \trb :%s/\s\+$//g<CR>
nnoremap \tsb /\s\+$<CR>
" arglist
nnoremap \tra :argdo s/\s\+$//g<CR>
nnoremap \tsa :vim /\s\+$/ ##<CR>
" quickfix list
nnoremap \trq :cdo s/\s\+$//g<CR>


" ---- Plugins ---- "

packadd minpac
call minpac#init()

call minpac#add('airblade/vim-gitgutter')
call minpac#add('ap/vim-css-color')
call minpac#add('arcticicestudio/nord-vim')
call minpac#add('carlitux/deoplete-ternjs')
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
call minpac#add('nanotech/jellybeans.vim')
call minpac#add('othree/jspc.vim')
call minpac#add('sjl/badwolf')
call minpac#add('scrooloose/nerdcommenter')
call minpac#add('scrooloose/nerdtree')
call minpac#add('Shougo/deoplete.nvim')
call minpac#add('Shougo/neoinclude.vim')
call minpac#add('sirver/UltiSnips')
call minpac#add('sjl/gundo.vim')
call minpac#add('ternjs/tern_for_vim')
call minpac#add('tommcdo/vim-exchange')
call minpac#add('tpope/tpope-vim-abolish')
call minpac#add('tpope/vim-endwise')
call minpac#add('tpope/vim-fugitive')
call minpac#add('tpope/vim-repeat')
call minpac#add('tpope/vim-surround')
call minpac#add('tpope/vim-unimpaired')
call minpac#add('tpope/vim-sleuth')
call minpac#add('tyrannicaltoucan/vim-deep-space')
call minpac#add('vim-airline/vim-airline')
call minpac#add('vim-airline/vim-airline-themes')
call minpac#add('vivien/vim-linux-coding-style')
call minpac#add('w0rp/ale')
call minpac#add('zchee/deoplete-clang')

" colorscheme
let g:nord_comment_brightness = 10

if $THEME == "" || $THEME == "default"
   let scheme_name = 'deep-space'
   let airline_scheme_name = 'deep_space'
else
   let scheme_name = $THEME
   let airline_scheme_name = $THEME
endif
execute 'colorscheme' scheme_name

" true color
set termguicolors


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
let g:airline_section_c = '%f'

" ---- cscope mappings ---- "

" legend: s - symbol, g - definition,
"         d - functions called by this function,
"         c - functions calling this function,
"         t - text string, e - egrep pattern,
"         f - file, i - files #including this file
nnoremap <leader>fs :cs f s <cword><CR>
nnoremap <leader>fg :cs f g <cword><CR>
nnoremap <leader>fd :cs f d <cword><CR>
nnoremap <leader>fc :cs f c <cword><CR>
nnoremap <leader>ft :cs f t <cword><CR>
nnoremap <leader>fe :cs f e <cword><CR>
nnoremap <leader>ff :cs f f <cword><CR>
nnoremap <leader>fi :cs f i <cword><CR>


" ---- deoplete config ---- "
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#clang#libclang_path="/usr/lib/libclang.so"
let g:deoplete#sources#clang#clang_header="/usr/lib/clang"

" close preview window when leaving insert mode
autocmd InsertLeave * if pumvisible() == 0 | pclose | endif

" ---- switch to header/source ---- "
nnoremap <leader>e. :FSHere<CR>
nnoremap <leader>et :FSTab<CR>
nnoremap <leader>ek :FSAbove<CR>
nnoremap <leader>ej :FSBelow<CR>
nnoremap <leader>eh :FSLeft<CR>
nnoremap <leader>el :FSRight<CR>
nnoremap <leader>ewk :FSAbove<CR>
nnoremap <leader>ewj :FSBelow<CR>
nnoremap <leader>ewh :FSLeft<CR>
nnoremap <leader>ewl :FSRight<CR>

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

" fzf rg integration
command! -bang -nargs=* FzfRg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

" fzf ag shortcuts
nnoremap <leader>ag :FzfAg <C-R><C-W><CR>
nnoremap <leader>af :FzfAg <C-R><C-W>\(<CR>
nnoremap <leader>as :FzfAg struct <C-R><C-W> {<CR>

" fzf rg shortcuts
nnoremap <leader>rg :FzfRg <C-R><C-W><CR>
nnoremap <leader>rf :FzfRg <C-R><C-W>\(<CR>
nnoremap <leader>rs :FzfRg struct <C-R><C-W> {<CR>

let g:linuxsty_patterns = [ "/usr/src/", "/linux" ]

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
