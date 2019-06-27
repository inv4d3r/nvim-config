" ---- Defaults ---- "

" buffer auto update
set autoread
au FocusGained,BufEnter * :silent! !
au FocusLost,WinLeave * :silent! noautocmd w

" folds configuration
set foldmethod=syntax
set foldlevelstart=4
set foldopen=all
set foldclose=all

" persistent undo
set undofile
set undodir=~/.vim/undodir

"file search path
set path=./**,/usr/include/**

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
set listchars=tab:→ ,nbsp:¬
set list

" always copy to plus register
set clipboard=unnamedplus

" comply with Linux kernel coding style "
set colorcolumn=81,101,121

" ---- Highlighting ---- "

highlight debugPC ctermbg=gray guibg=gray
highlight debugBreakpoint ctermbg=gray guibg=gray
autocmd ColorScheme * highlight debugPC ctermbg=gray guibg=gray
autocmd ColorScheme * highlight debugBreakpoint ctermbg=gray guibg=gray

" max column highlight
highlight ColorColumn ctermbg=167 guibg=167

" trailing whitespace
highlight ExtraWhitespace ctermfg=red guifg=red ctermbg=red guibg=red
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" tabs
highlight AnyTab ctermfg=gray guifg=gray
autocmd ColorScheme * highlight AnyTab ctermfg=gray guifg=gray
autocmd BufWinEnter * syntax match AnyTab /\t\+/

" nbsp
highlight NonBreakingSpace ctermbg=red guibg=red
autocmd ColorScheme * highlight NonBreakingSpace ctermbg=yellow guibg=yellow
autocmd BufWinEnter * syntax match NonBreakingSpace /\%xa0/

" cppman for cpp files
if executable("cppman")
  autocmd FileType cpp set keywordprg=:term\ cppman
endif

" ---- Mappings ---- "
nnoremap <C-l> :nohl<CR>

" execute command from current line
nnoremap <leader><CR> :execute getline(".")<CR>

" view alternative buffer
nnoremap <space> <C-^>

" go to current file's path
nnoremap <leader>pc :cd %:p:h<CR>:pwd<CR>

" edit (with netrw) current file's path
nnoremap <leader>pe :e %:p:h<CR>:pwd<CR>

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
nnoremap <leader>bsl :ls<CR>:sb 
nnoremap <leader>bv :vert sb <C-D>
nnoremap <leader>bvl :ls<CR>:vert sb 

" trailing whitespace mappings
" current buffer
nnoremap <leader>wrb :%s/\s\+$//g<CR>
nnoremap <leader>wsb /\s\+$<CR>
" arglist
nnoremap <leader>wra :argdo %s/\s\+$//g<CR>
nnoremap <leader>wsa :vim /\s\+$/ ##<CR>
" quickfix list
nnoremap <leader>wrq :cdo s/\s\+$//<CR>

" search current word in arglist
nnoremap <leader>v :vim <cword> ##<CR>


" ---- Plugins ---- "

packadd minpac
call minpac#init()

" one to rule them all
call minpac#add('k-takata/minpac', { 'type' : 'opt' })

" highlight plugings
call minpac#add('RRethy/vim-hexokinase')
call minpac#add('airblade/vim-gitgutter')
call minpac#add('kshenoy/vim-signature')

" colorscheme plugins
call minpac#add('dracula/vim')
call minpac#add('arcticicestudio/nord-vim')
call minpac#add('morhetz/gruvbox')
call minpac#add('nanotech/jellybeans.vim')
call minpac#add('sjl/badwolf')
call minpac#add('tyrannicaltoucan/vim-deep-space')
call minpac#add('w0ng/vim-hybrid')
call minpac#add('kristijanhusak/vim-hybrid-material')

" autocompletion & tags plugins
call minpac#add('neoclide/coc.nvim')
"call minpac#add('Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins'})
"call minpac#add('Shougo/neoinclude.vim')
"call minpac#add('carlitux/deoplete-ternjs')
"call minpac#add('tweekmonster/deoplete-clang2')
"call minpac#add('zchee/deoplete-jedi')
call minpac#add('majutsushi/tagbar')
"call minpac#add('ludovicchabant/vim-gutentags')
call minpac#add('othree/jspc.vim')
call minpac#add('ternjs/tern_for_vim')

" file & fuzzy navigation
call minpac#add('derekwyatt/vim-fswitch')
call minpac#add('junegunn/fzf', { 'do' : './install --all' })
call minpac#add('junegunn/fzf.vim')

" utility plugins
call minpac#add('milkypostman/vim-togglelist')
call minpac#add('dhruvasagar/vim-table-mode')
call minpac#add('godlygeek/tabular')
call minpac#add('gregsexton/gitv')
call minpac#add('tommcdo/vim-exchange')
call minpac#add('roxma/vim-tmux-clipboard')
call minpac#add('christoomey/vim-tmux-navigator')
call minpac#add('sjl/gundo.vim')
call minpac#add('tpope/tpope-vim-abolish')
call minpac#add('tpope/vim-endwise')
call minpac#add('tpope/vim-dispatch')
call minpac#add('tpope/vim-fugitive')
call minpac#add('tpope/vim-repeat')
call minpac#add('tpope/vim-surround')
call minpac#add('tpope/vim-unimpaired')
call minpac#add('tpope/vim-sleuth')
call minpac#add('tpope/vim-vinegar')

" programming helpers
call minpac#add('sirver/UltiSnips')
call minpac#add('vivien/vim-linux-coding-style')
"call minpac#add('vim-syntastic/syntastic')
"call minpac#add('w0rp/ale')
call minpac#add('scrooloose/nerdcommenter')

" lightline
call minpac#add('itchyny/lightline.vim')
call minpac#add('cocopon/lightline-hybrid.vim')
call minpac#add('shinchu/lightline-gruvbox.vim')
call minpac#add('844196/lightline-badwolf.vim')

" colorscheme
if $THEME == "" || $THEME == "default"
   let scheme_name = 'deep-space'
   let airline_scheme_name = 'deep_space'
elseif $THEME == "grayscale"
   let g:enable_bold_font = 1
   let g:enable_italic_font = 1
   "let scheme_name = 'hybrid'
   "let scheme_name = 'hybrid_material'
   let scheme_name = 'hybrid_reverse'
   "let airline_scheme_name = 'badcat'
   "let airline_scheme_name = 'base16_grayscale'
   let airline_scheme_name = 'minimalist'
else
   let scheme_name = $THEME
   let airline_scheme_name = $THEME
endif
execute 'colorscheme' scheme_name

" ---- lightline configution ---- "
" hybrid - (cocopon) hybrid, deus, one, solarized
" dracula - darcula
" grayscale - hybrid (plain style), seoul256, OldHope
" jellybeans
" nord
" gruvbox - (shinchu) gruvbox
" badwolf - (844196) badwolf, molokai

      "\   'ale': '%{ale#statusline#Status()}',
let g:lightline = {
      \ 'colorscheme': 'hybrid',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'tagbar', 'gitbranch', 'readonly', 'relativepath', 'modified' ] ]
      \ },
      \ 'component': {
      \   'tagbar': '%{tagbar#currenttag("%s", "", "f")}'
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
      \ }

" ---- syntastic configuration ---- "
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0
"let g:syntastic_c_checkers = [ "checkpatch", "clang_tidy" ]
"let g:syntastic_cpp_check_header = 1

" ---- tags configuration ---- "
" ---- generation
set tags=tags
"let g:gutentags_modules = [ "ctags" ]
"let g:gutentags_ctags_extra_args = ["--extra=+q", "/usr/include/c++"]
"let g:gutentags_trace = 1

" ---- navigation
" open tag in vertical split
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
map g<A-]> :vsp <CR>:exec("tjump ".expand("<cword>"))<CR>
" already defined bindings:
" CTRL-W CTRL-] - open tag in horizontal split
" CTRL-W } - open tag in preview window
" CTRL-W z - close preview window
" CTRL-t - tag stack jump
" from vim-unimpaired:
" ]CTRL-T - preview window next tag
" [CTRL-T - preview window previous tag

" true color
set termguicolors

" ---- extra windows ---- "
nnoremap <F3> :GundoToggle<CR>
nnoremap <F4> :Tagbar<CR>

" ---- cscope mappings ---- "

" legend: s - symbol, g - definition,
"         a - find places where this symbol is assigned a value
"         c - functions calling this function,
"         d - functions called by this function,
"         t - text string, e - egrep pattern,
"         f - file, i - files #including this file
nnoremap <leader>fa :cs f a <cword><CR>
nnoremap <leader>fs :cs f s <cword><CR>
nnoremap <leader>fg :cs f g <cword><CR>
nnoremap <leader>fd :cs f d <cword><CR>
nnoremap <leader>fc :cs f c <cword><CR>
nnoremap <leader>ft :cs f t <cword><CR>
nnoremap <leader>fe :cs f e <cword><CR>
nnoremap <leader>ff :cs f f <cword><CR>
nnoremap <leader>fi :cs f i <cword><CR>
nnoremap <leader>fxa :scs f a <cword><CR>
nnoremap <leader>fxs :scs f s <cword><CR>
nnoremap <leader>fxg :scs f g <cword><CR>
nnoremap <leader>fxd :scs f d <cword><CR>
nnoremap <leader>fxc :scs f c <cword><CR>
nnoremap <leader>fxt :scs f t <cword><CR>
nnoremap <leader>fxe :scs f e <cword><CR>
nnoremap <leader>fxf :scs f f <cword><CR>
nnoremap <leader>fxi :scs f i <cword><CR>
nnoremap <leader>fla :lcs f a <cword><CR>
nnoremap <leader>fls :lcs f s <cword><CR>
nnoremap <leader>flg :lcs f g <cword><CR>
nnoremap <leader>fld :lcs f d <cword><CR>
nnoremap <leader>flc :lcs f c <cword><CR>
nnoremap <leader>flt :lcs f t <cword><CR>
nnoremap <leader>fle :lcs f e <cword><CR>
nnoremap <leader>flf :lcs f f <cword><CR>
nnoremap <leader>fli :lcs f i <cword><CR>
set cscopequickfix=s-,c-,d-,i-,t-,e-,a-

" ---- deoplete config ---- "
"let g:deoplete#enable_at_startup = 1
"let g:deoplete#sources#clang#libclang_path="/usr/lib64/libclang.so"
"let g:deoplete#sources#clang#clang_header="/usr/lib64/clang"

" close preview window when leaving insert mode
"autocmd InsertLeave * if pumvisible() == 0 | pclose | endif

" ---- switch to header/source ---- "
nnoremap <leader>e. :FSHere<CR>
nnoremap <leader>et :FSTab<CR>
nnoremap <leader>ek :FSAbove<CR>
nnoremap <leader>ej :FSBelow<CR>
nnoremap <leader>eh :FSLeft<CR>
nnoremap <leader>el :FSRight<CR>
nnoremap <leader>ewk :FSSplitAbove<CR>
nnoremap <leader>ewj :FSSplitBelow<CR>
nnoremap <leader>ewh :FSSplitLeft<CR>
nnoremap <leader>ewl :FSSplitRight<CR>

" ---- fzf config ---- "
let g:fzf_command_prefix = "Fzf"
nnoremap <leader>za :FzfAg<CR>
nnoremap <leader>zb :FzfBuffers<CR>
nnoremap <leader>zc :FzfCommits<CR>
nnoremap <leader>zd :FzfBCommits<CR>
nnoremap <leader>ze :FzfCommands<CR>
nnoremap <leader>zf :FzfFiles<CR>
nnoremap <leader>zh: :FzfHistory:<CR>
nnoremap <leader>zh/ :FzfHistory/<CR>
nnoremap <leader>zg :FzfGFiles<CR>
nnoremap <leader>zg? :FzfGFiles?<CR>
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

" ---- Substitute configuration ---- "
map <leader>s :S/

" ---- tmux seamless navigation ---- "
let g:tmux_navigator_no_mappings = 1

" ---- UltiSnips configuration ---- "
let g:UltiSnipsSnippetsDir="~/.config/nvim/UltiSnips"
let g:UltiSnipsExpandTrigger="<C-j>"
let g:UltiSnipsEnableSnipMate=0

" ---- Debugging ---- "
let g:termdebug_wide = 163
packadd termdebug

nnoremap <silent> <leader>tg :Gdb<CR>
nnoremap <silent> <leader>tp :Program<CR>
nnoremap <silent> <leader>ts :Source<CR>

nnoremap <silent> <F5> :Continue<CR>
nnoremap <silent> <F6> :Finish<CR>
nnoremap <silent> <F7> :Stop<CR>
nnoremap <silent> <F8> :Clear<CR>
nnoremap <silent> <F9> :Break<CR>
nnoremap <silent> <F10> :Over<CR>
nnoremap <silent> <F11> :Step<CR>

" ---- coc.nvim configuration ---- "

" use tab for trigger completion with characters ahead and navigate.
" use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
"inoremap <silent><expr> <TAB>
      "\ pumvisible() ? "\<C-n>" :
      "\ <SID>check_back_space() ? "\<TAB>" :
      "\ coc#refresh()
"inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

"function! s:check_back_space() abort
  "let col = col('.') - 1
  "return !col || getline('.')[col - 1]  =~# '\s'
"endfunction

" use <c-space> for trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" use `[g` and `]g` for navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
vmap <leader>ga  <Plug>(coc-codeaction-selected)
nmap <leader>ga  <Plug>(coc-codeaction-selected)

" remap for do codeAction of current line
nmap <leader>gc  <Plug>(coc-codeaction)

" remap keys for gotos
nmap <silent> <leader>gd. <Plug>(coc-definition)
nnoremap <silent> <leader>gdd :call CocLocations('ccls','textDocument/definition', {}, 'drop')<cr>
nnoremap <silent> <leader>gds :call CocLocations('ccls','textDocument/definition', {}, 'split')<cr>
nnoremap <silent> <leader>gdv :call CocLocations('ccls','textDocument/definition', {}, 'vsplit')<cr>
nmap <silent> <leader>gl. <Plug>(coc-declaration)
nnoremap <silent> <leader>gld :call CocLocations('ccls','textDocument/declaration', {}, 'drop')<cr>
nnoremap <silent> <leader>gls :call CocLocations('ccls','textDocument/declaration', {}, 'split')<cr>
nnoremap <silent> <leader>glv :call CocLocations('ccls','textDocument/declaration', {}, 'vsplit')<cr>
nmap <silent> <leader>gt. <Plug>(coc-type-definition)
nnoremap <silent> <leader>gtd :call CocLocations('ccls','textDocument/typeDefinition', {}, 'drop')<cr>
nnoremap <silent> <leader>gts :call CocLocations('ccls','textDocument/typeDefinition', {}, 'split')<cr>
nnoremap <silent> <leader>gtv :call CocLocations('ccls','textDocument/typeDefinition', {}, 'vsplit')<cr>
nmap <silent> <leader>gi. <Plug>(coc-implementation)
nnoremap <silent> <leader>gid :call CocLocations('ccls','textDocument/implementation', {}, 'drop')<cr>
nnoremap <silent> <leader>gis :call CocLocations('ccls','textDocument/implementation', {}, 'split')<cr>
nnoremap <silent> <leader>giv :call CocLocations('ccls','textDocument/implementation', {}, 'vsplit')<cr>
nmap <silent> <leader>gr. <Plug>(coc-references)
nnoremap <silent> <leader>grd :call CocLocations('ccls','textDocument/references', {}, 'drop')<cr>
nnoremap <silent> <leader>grs :call CocLocations('ccls','textDocument/references', {}, 'split')<cr>
nnoremap <silent> <leader>grv :call CocLocations('ccls','textDocument/references', {}, 'vsplit')<cr>

" remap for format selected region
vmap <leader>gf  <Plug>(coc-format-selected)
nmap <leader>gf  <Plug>(coc-format-selected)

" show documentation in preview window
nnoremap <silent> <leader>gk :call <SID>show_documentation()<CR>

" remap for rename current word
nmap <leader>gn <Plug>(coc-rename)

" fix autofix problem of current line
nmap <leader>gp  <Plug>(coc-fix-current)

" using CocList
" show all diagnostics
nnoremap <silent> <leader>da :<C-u>CocList diagnostics<cr>
" manage extensions
nnoremap <silent> <leader>e  :<C-u>CocList extensions<cr>
" show commands
nnoremap <silent> <leader>dc :<C-u>CocList commands<cr>
" find symbol of current document
nnoremap <silent> <leader>do :<C-u>CocList outline<cr>
" search workspace symbols
nnoremap <silent> <leader>ds :<C-u>CocList -I symbols<cr>
" do default action for next item.
nnoremap <silent> <leader>dj :<C-u>CocNext<CR>
" do default action for previous item.
nnoremap <silent> <leader>dk :<C-u>CocPrev<CR>
" resume latest coc list
nnoremap <silent> <leader>dp :<C-u>CocListResume<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Use `:Format` for format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` for fold current buffer
command! -nargs=? Fold :call CocAction('fold', <f-args>)

" Cross references
" bases
nnoremap <silent> <leader>xb :call CocLocations('ccls','$ccls/inheritance')<cr>
" bases of up to 3 levels
nnoremap <silent> <leader>xB :call CocLocations('ccls','$ccls/inheritance',{'levels':3})<cr>
" derived
nnoremap <silent> <leader>xd :call CocLocations('ccls','$ccls/inheritance',{'derived':v:true})<cr>
" derived of up to 3 levels
nnoremap <silent> <leader>xD :call CocLocations('ccls','$ccls/inheritance',{'derived':v:true,'levels':3})<cr>

" caller
nnoremap <silent> <leader>xc :call CocLocations('ccls','$ccls/call')<cr>
" callee
nnoremap <silent> <leader>xC :call CocLocations('ccls','$ccls/call',{'callee':v:true})<cr>

" $ccls/member
" member variables / variables in a namespace
nnoremap <silent> <leader>xm :call CocLocations('ccls','$ccls/member')<cr>
" member functions / functions in a namespace
nnoremap <silent> <leader>xf :call CocLocations('ccls','$ccls/member',{'kind':3})<cr>
" nested classes / types in a namespace
nnoremap <silent> <leader>xs :call CocLocations('ccls','$ccls/member',{'kind':2})<cr>

nnoremap <silent> <leader>xv :call CocLocations('ccls','$ccls/vars')<cr>
nnoremap <silent> <leader>xV :call CocLocations('ccls','$ccls/vars',{'kind':1})<cr>

