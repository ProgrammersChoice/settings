
""""""""""""""""[Plugins]""""""""""""""""
""""""""""""""""[Plugins]""""""""""""""""
""""""""""""""""[Plugins]""""""""""""""""

"설치할 플러긴을 begin 과 end 사이에 설치
"PlugInstall로 설치

call plug#begin('~/.vim/plugged')

" let Vundle manage Vundle, required
" Search [:PlugSearch]  install is [:PlugInstall]  [PlugUpdate]to delete erase from here and type [:PlugClean]
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'ryanoasis/vim-devicons'
Plug 'vim-airline/vim-airline' "bottom line pretty
Plug 'vim-airline/vim-airline-themes' "bottom line pretty
Plug 'airblade/vim-gitgutter' "see the changes for git
Plug 'tpope/vim-fugitive' "using git [Gstatus] [Gdiff] [Gblame] [Glog] [q:cprev [Q:cfirst ]q:cnext ]Q:clast
Plug 'tpope/vim-unimpaired' "to navigate quickfix buffer
"using glog -> [q : cprev ... Glog -10, Glog -1- --reverse
"The easiest way to navigate the quickfix list (or the location list, for that
"matter) is the unimpaired plugin.
"
"Once the quickfix window is populated, [q and ]q go forward and back
"(respectively) in the quickfix list. [Q and ]Q go to the beginning and end
"(which is especially handy if you only have one item in the list; this makes
"vim complain about [q and ]q). So the workflow is:
":
Plug 'scrooloose/syntastic' "code error conventions
"Plug 'ctrlpvim/ctrlp.vim' "[ctrl+p] 파일 찾기, [C-p] [C-t] [C-v] [C-x]
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim' "Rg, Files, Lines, Commits //cfdo %s///g|update
Plug 'pechorin/any-jump.vim'
Plug 'dyng/ctrlsf.vim'
Plug 'stsewd/fzf-checkout.vim'
Plug 'airblade/vim-rooter'
Plug 'rking/ag.vim' "v, h, t, go
Plug 'mileszs/ack.vim'
Plug 'tpope/vim-surround' "cs'] cSw] csw] ysiw] yss] ds) VS]
Plug 'kshenoy/vim-signature' "ma <- marking ma<-delete, m/(list)
Plug 'tpope/vim-dispatch'
Plug 'oblitum/rainbow' "different color () [rainbowtoggle]
Plug 'tpope/vim-commentary' "쉬운 주석  [gcap],[gcc], [선택 gc] , [7,17Commentary], [g/TODO/Commentary]
"Plug 'christoomey/vim-tmux-navigator'
"Plug 'taglist-plus'
Plug 'majutsushi/tagbar'
Plug 'wesleyche/SrcExpl'
Plug 'tpope/vim-repeat'
Plug 'Yggdroot/vim-mark' "색칠 [\m] [\n]
"Plug 'vmark.vim--Visual-Bookmarking'
" Snippets are separated from the engine. Add this if you want them:
Plug 'SirVer/ultisnips'
"Plug 'honza/vim-snippets'
Plug 'Lokaltog/vim-easymotion' "\\s \\k \\j \\w \\b
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"Plug 'vim-scripts/SyntaxComplete'
"Plug 'Shougo/neocomplete.vim'
"Plug 'Valloric/YouCompleteMe'
"Compile your package with :GoBuild, install it with :GoInstall or test it
"with :GoTest. Run a single test with :GoTestFunc).
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'jpalardy/vim-slime', { 'for': 'python' }
Plug 'hanschen/vim-ipython-cell', { 'for': 'python' }

"Plug 'jeffkreeftmeijer/vim-numbertoggle'
"Plug 'Rip-Rip/clang_complete'

"[color scheme]
" vimcolors.com
"Plug 'flazz/vim-colorschemes' "각종 컬러
"Plug 'altercation/vim-colors-solarized'
"Plug 'desert-warm-256'
"Plug 'kchmck/vim-coffee-script'
"Plug 'Lokaltog/vim-powerline.git'
"Plug 'jacoborus/tender.vim'
Plug 'morhetz/gruvbox'
call plug#end()



""""""""""""""""[general Vim Settings]""""""""""""""""
""""""""""""""""[general Vim Settings]""""""""""""""""
""""""""""""""""[general Vim Settings]""""""""""""""""
imap kj <Esc>
nnoremap zz :q!<CR>
command! Config execute ":e ~/.vimrc"
command! Reload execute ":source ~/.vimrc"
command! Filehistory execute ":BCommits"
nmap com :Commands<CR>
nnoremap <leader>j :AnyJump<CR>
nnoremap <leader>w :w<CR>
map <Leader>n :NERDTreeToggle<CR>
map <Leader>t :TagbarToggle<CR>
set mouse=a
set nopaste
set encoding=UTF-8
set cb=unnamed " 윈도우에서 복사하기 위해 *레지스터 이용 +가 기본
set nocompatible              " be improved, required
filetype off                  " required
syntax enable
colorscheme gruvbox
let g:gruvbox_contrast_dark='hard'
"filetype plugin indent on
"set t_Co=16
set t_Co=256
let g:mwDefaultHighlightingPalette = 'maximum'
set background=dark
"let g:solarzedterm_colors=256
set autoindent
set cindent
set tabstop=8 "tab을 8개의 공백으로
set shiftwidth=8 " 들여쓰기시 기본 공백 크기
set relativenumber
set nu
set ai
set ts=8
set sw=4
set sts=4
set backspace=indent,eol,start
"set cc=80
set hlsearch
"highlight Visual cterm=NONE ctermbg=3 ctermfg=1 guibg=Grey40
highlight ColorColumn ctermbg=6 guibg=LightSeaGreen
highlight Visual ctermfg=3

if $TERM =~ 'xterm-256color'
    set noek
endif
let &t_SI.="\e[5 q"
let &t_SR.="\e[4 q"
let &t_EI.="\e[1 q"
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif


"WSL yank support
let s:clip = '/mnt/c/Windows/System32/clip.exe'  " change this path according to your mount point
if executable(s:clip)
    augroup WSLYank
        autocmd!
        autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
    augroup END
endif

"""""""""""""""""[PLUG Options]""""""""""""""""
"""""""""""""""""[PLUG Options]""""""""""""""""
"""""""""""""""""[PLUG Options]""""""""""""""""
""""[vim ipython]""""
" always use tmux
let g:slime_target = 'tmux'

" fix paste issues in ipython
let g:slime_python_ipython = 1

" always send text to the top-right pane in the current tmux tab without asking
let g:slime_default_config = {
            \ 'socket_name': get(split($TMUX, ','), 0),
            \ 'target_pane': '{top-right}' }
let g:slime_dont_ask_default = 1

" Keyboard mappings. <Leader> is \ (backslash) by default

" map <Leader>s to start IPython
nnoremap <Leader>st :SlimeSend1 ipython --matplotlib<CR>
" map <Leader>r to run script
"nnoremap <Leader>e :IPythonCellRun<CR>
" map <Leader>R to run script and time the execution
nnoremap <Leader>E :IPythonCellRunTime<CR>
" map <Leader>c to execute the current cell
"nnoremap <Leader>c :IPythonCellExecuteCell<CR>
" map <Leader>C to execute the current cell and jump to the next cell
"nnoremap <Leader>C :IPythonCellExecuteCellJump<CR>
" map <Leader>l to clear IPython screen
nnoremap <Leader>c :IPythonCellClear<CR>
" map <Leader>x to close all Matplotlib figure windows
"nnoremap <Leader>x :IPythonCellClose<CR>

" map [c and ]c to jump to the previous and next cell header
"nnoremap [c :IPythonCellPrevCell<CR>
"nnoremap ]c :IPythonCellNextCell<CR>
" map <Leader>h to send the current line or current selection to IPython
nmap <Leader>e <Plug>SlimeLineSend
xmap <Leader>e <Plug>SlimeRegionSend
" map <Leader>p to run the previous command
"nnoremap <Leader>p :IPythonCellPrevCommand<CR>
" map <Leader>Q to restart ipython
nnoremap <Leader>Q :IPythonCellRestart<CR>
" map <Leader>d to start debug mode
nnoremap <Leader>d :SlimeSend1 %debug<CR>
" map <Leader>q to exit debug mode or IPython
nnoremap <Leader>q :SlimeSend1 exit<CR>

""""[easy motion]""""
""""[easy motion]""""
" s{char}{char} to move to {char}{char}
nmap , <Plug>(easymotion-overwin-f2)

""""[fzf]""""
""""[fzf]""""
nnoremap <C-p> :Files<Cr>
nmap ?? :Rg<Cr>
nmap // :BLines<Cr>
let g:fzf_layout = { 'window' : { 'width': 0.8, 'height': 0.8 } }
let $FZF_DEFAULT_OPTS='--reverse'
nnoremap <leader>gc :GCheckout<CR>


""""[airline]""""
""""[airline]""""
let g:Powerline_symbols = 'fancy'
set laststatus=2 " 상 태바 표시를 항상 함


"[Ulti snip settings]""""
"[Ulti snip settings]""""
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"


"[omni completion]""""
"[omni completion]""""
" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php '=[^. \t->\h\w*\|\h\w*::'
let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] \t\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp ='[^.[:digit:] *\t]\%(\.\|\-)\|\h\w*:'



"for [rainbow] plugin""""
"for [rainbow] plugin""""
au FileType c,cp,obj,objcpp call rainbow#load()

"setting for syntaxcomplete => setup syntaxcomplete for every filetype
if has("autocmd") && exists("+omnifunc")
	autocmd Filetype *
			\    if &omnifunc == "" |
			\        setlocal omnifunc=syntaxcomplete#Complete |
			\    endif
endif


"[speed up ag]""""
"[speed up ag]""""
if executable('ag')
    "let g:ackprg = "ag --nogroup --column --vimgrep"
    let g:ackprg = "ag --vimgrep"
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif
"nnoremap ,ag :Ag! --ignore tags --ignore cscope.out
"nnoremap ,ac :Ag!


"[settings for ultisnips]""""
"[settings for ultisnips]""""
":UltiSnipsEdit is make custom stnips for that workspace
" "Trigger configuratio. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
" prevent Ultisnips from removing our carefully-crafted mappings.
let g:UltiSnipsMappingsToIgnore = ['autocomplete']
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"


"[air line top]""""
"[air line top]""""
let g:airline#extensions#tabline#enabled = 1
"set AirlineTheme solarized "call it once
let g:airline_solarized_bg='dark'
let g:airline_theme='gruvbox'

if (has("termguicolors"))
    set termguicolors
endif
nmap <leader>] :bnext<CR>
nmap <leader>[ :bprevious<CR>
nmap <leader>o :enew<CR>
nmap <leader>p :bp <BAR> bd #<CR>


"[Syntastic option]""""
"[Syntastic option]""""
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
 " let g:syntastic_always_populate_loc_list = 1
 " let g:syntastic_auto_loc_list = 1
 " let g:syntastic_check_on_open = 1
 " let g:syntastic_check_on_wq = 0
 "

"[CTag settings]""""
"[CTag settings]""""
"set tag./tags
"하위로 이동하면서 tag찾기
function Maketags()
    call system("~/make_tags.sh")
endfunction
function Addtags()
    call system("~/tags.sh")
endfunction
"nmap ,tag :call Addtags()<CR>
"nmap ,ctag :call Maketags()<CR>
"arch=arm version


"[CSCOPE settings]""""
"[CSCOPE settings]""""
set csprg=/usr/bi/cscope
set csto=0
set cst
set nocsverb
cs add ./cscope.out
set csverb
set csre
"autoload cscope
function! LoadCscope()
  let db = findfile("cscope.out", ".;")
  if (!empty(db))
    let path = strpart(db, 0, match(db, "/cscope.out$"))
    set nocscopeverbose " suppress 'duplicate connection' error
    exe "cs add " . db . " " . path
    set cscopeverbose
  endif
endfunction
au BufEnter /* call LoadCscope()
func! Css()
	let css = expand("<cword>")
	new
	exe "cs find s ".css
	if getline(1) == ""
		exe "q!"
	endif
endfunc
"nmap ,css :call Css()<cr>
func! Csc()
	let csc = expand("<cword>")
	new
	exe "cs find c ".csc
	if getline(1) == ""
		exe "q!"
	endif
endfunc
"nmap ,csc :call Csc()<cr>
func! Csg()
	let csg = expand("<cword>")
	new
	exe "cs find g ".csg
	if getline(1) == ""
		exe "q!"
	endif
endfunc
"nmap ,csg :call Csg()<cr>



"[Taglist settings]""""
"[Taglist settings]""""
filetype on
let Tlist_Ctags_Cmd="/usr/bin/ctags"
let Tlist_Inc_winwidth = 0
let Tlist_Exit_OnlyWindow=0
let Tlist_Auto_Open=0
let Tlist_Use_Right_Window=0


"[Source Explorer]""""
"[Source Explorer]""""
nmap <C-H> <C-W>h
nmap <C-J> <C-W>j
nmap <C-K> <C-W>k
nmap <C-L> <C-W>l
let g:SrcExpl_winHeight=8
let g:SrcExpl_refreshTime=100
let g:SrcExpl_jumpKey= "<ENTER>"
let g:SrcExpl_gobackKey= "<SPACE>"
let g:SrcExpl_isUpdateTags = 0


"[set white space]""""
"[set white space]""""
let g:HLSpace = 1
function! Whitespace()
    if g:HLSpace
        if !exists('b_ws')
            highlight Conceal ctermbg=NONE ctermfg=240 cterm=NONE guibg=NONE guifg=#585858 gui=NONE
            highlight link Whitespace Conceal
            let b_ws = 1
        endif
        syntax clear Whitespace
        syntax match Whitespace / / containedin=ALL conceal cchar=·
        setlocal conceallevel=2 concealcursor=c
    else
        setlocal conceallevel=0 concealcursor=c
    endif
    let g:HLSpace = !g:HLSpace
endfunction
" augroup Whitespace
"     autocmd!
"     autocmd BufEnter,WinEnter * call Whitespace()
" augroup END
nmap <F12> :call Whitespace()<CR>
function! Maketags()
	call system("/home/hongiee/ctag.sh")
endfunction
"nmap ,tag :call Maketags()<CR>
"
"[set paste]""""
let g:paste = 1
function! Togglepaste()
    if g:paste
	set mouse=
	set paste
    else
	set mouse=a
	set nopaste
    endif
    let g:paste = !g:paste
endfunction
" augroup Whitespace
"     autocmd!
"     autocmd BufEnter,WinEnter * call Whitespace()
" augroup END

nmap <F10> :call Togglepaste()<CR>

"[NERD Tree]""""
"[NERD Tree]""""
let g:NERDTreeDirArrows = 1
let g:NERDTreeDirArrowExpandable = '▶'
let g:NERDTreeDirArrowCollapsible = '◀'
let g:NERDTreeGlyphReadOnly = "RO"
let NERDTreeWinPos ="left"
nmap <F7> :NERDTreeToggle<CR>
nmap <F8> :SrcExplToggle<CR>
nmap <F9> :TagbarToggle<CR>
"nmap <F9> :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>
"nmap ,m :NERDTreeToggle<CR>
""tabsize  ls명령이 파일 버퍼들 보는것임
"map ,1 :b!1<CR> "1번 파일 버퍼로 이동
"map ,2 :b!2<CR>
"map ,3 :b!3<CR>
"map ,4 :b!4<CR>
"map ,5 :b!5<CR>
"map ,6 :b!6<CR>
"map ,7 :b!7<CR>
"map ,8 :b!8<CR>
"map ,9 :b!9<CR>
"map ,0 :b!0<CR>
"map ,x :bn!<CR>  "다음 파일 버퍼
"map ,y :bp!<CR>
"map ,w :bw<CR>  "현재 파일 버퍼를 닫음

"[CtrlSF]""""
"[CtrlSF]""""
nmap <leader>a :CtrlSF -R ""<Left>
nmap <leader>A <Plug>CtrlSFCwordPath -W<CR>
nmap <leader>c :CtrlSFFocus<CR>
nmap <leader>C :CtrlSFToggle<CR>
" Substitute the word under the cursor.
nmap <leader>s :%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>

if has("macunix")
  let g:ctrlsf_ackprg = '/usr/local/bin/rg'
elseif has("unix")
  let g:ctrlsf_ackprg = '/usr/bin/rg'
endif

let g:ctrlsf_winsize = '33%'
let g:ctrlsf_auto_close = 0
let g:ctrlsf_confirm_save = 0
let g:ctrlsf_auto_focus = {
    \ 'at': 'start',
    \ }


"[coc]""""
"[coc]""""
"Textedit will fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <F2> <Plug>(coc-rename)

" Formatting selected code.
"xmap <leader>f  <Plug>(coc-format-selected)
"nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" show all diagnostics.
nnoremap <silent><nowait> <space>a  :<c-u>coclist diagnostics<cr>
" manage extensions.
nnoremap <silent><nowait> <space>e  :<c-u>coclist extensions<cr>
" show commands.
nnoremap <silent><nowait> <space>c  :<c-u>coclist commands<cr>
" find symbol of current document.
nnoremap <silent><nowait> <space>o  :<c-u>coclist outline<cr>
" search workspace symbols.
nnoremap <silent><nowait> <space>s  :<c-u>coclist -i symbols<cr>
" do default action for next item.
nnoremap <silent><nowait> <space>j  :<c-u>cocnext<cr>
" do default action for previous item.
nnoremap <silent><nowait> <space>k  :<c-u>cocprev<cr>
" resume latest coc list.
nnoremap <silent><nowait> <space>p  :<c-u>coclistresume<cr>

function! FloatScroll(forward) abort
  let float = coc#util#get_float()
  if !float | return '' | endif
  let buf = nvim_win_get_buf(float)
  let buf_height = nvim_buf_line_count(buf)
  let win_height = nvim_win_get_height(float)
  if buf_height < win_height | return '' | endif
  let pos = nvim_win_get_cursor(float)
  if a:forward
    if pos[0] == 1
      let pos[0] += 3 * win_height / 4
    elseif pos[0] + win_height / 2 + 1 < buf_height
      let pos[0] += win_height / 2 + 1
    else
      let pos[0] = buf_height
    endif
  else
    if pos[0] == buf_height
      let pos[0] -= 3 * win_height / 4
    elseif pos[0] - win_height / 2 + 1  > 1
      let pos[0] -= win_height / 2 + 1
    else
      let pos[0] = 1
    endif
  endif
  call nvim_win_set_cursor(float, pos)
  return ''
endfunction

inoremap <silent><expr> <down> coc#util#has_float() ? FloatScroll(1) : "\<down>"
inoremap <silent><expr>  <up>  coc#util#has_float() ? FloatScroll(0) :  "\<up>"
