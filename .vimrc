"todo is change zshrc, ag, ctags, fugitive, gitgutter, 자동완성

"tmux keys
"tmux cpy : <prefix> [ to copy mode
"tmux close pane : <prefix> x

"
set nocompatible              " be iMproved, required
filetype off                  " required

"http://klutzy.nanabi.org/blog/2014/08/11/uses-this/
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
" Search [:PluginSearch]  install is [:PluginInstall]  to delete erase from here and type [:PluginClean]
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'vim-airline/vim-airline' "bottom line pretty
Plugin 'vim-airline/vim-airline-themes' "bottom line pretty
Plugin 'airblade/vim-gitgutter' "see the changes for git
Plugin 'tpope/vim-fugitive' "using git [Gdiff] [Gblame]
Plugin 'scrooloose/syntastic' "code error conventions
Plugin 'ctrlpvim/ctrlp.vim' "[ctrl+p] 파일 찾기
Plugin 'rking/ag.vim'
Plugin 'mileszs/ack.vim'
Plugin 'tpope/vim-surround' "cs'] cSw] csw] ysiw] yss) ds) VS]
Plugin 'kshenoy/vim-signature' "ma <- marking ma<-delete
Plugin 'tpope/vim-dispatch'
Plugin 'oblitum/rainbow' "different color () [rainbowtoggle]
Plugin 'tpope/vim-commentary' "쉬운 주석  [gcap],[gcc], [선택 gc] , [7,17Commentary], [g/TODO/Commentary]
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'taglist-plus'
Plugin 'Source-Explorer-srcexpl.vim'
Plugin 'tpope/vim-repeat'
Plugin 'Yggdroot/vim-mark' "색칠 [\m] [\n]
"Plugin 'vmark.vim--Visual-Bookmarking'


" color scheme  
" vimcolors.com   
Plugin 'flazz/vim-colorschemes' "각종 컬러
Plugin 'altercation/vim-colors-solarized'
Plugin 'desert-warm-256'
Plugin 'kchmck/vim-coffee-script'
"Plugin 'Lokaltog/vim-powerline.git'


"fast coding tools
"Track the engine.

" Snippets are separated from the engine. Add this if you want them:
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'easymotion/vim-easymotion' "\\s \\k \\j \\w \\b
Plugin 'vim-scripts/SyntaxComplete'
"Plugin 'Shougo/neocomplete'
Plugin 'jeffkreeftmeijer/vim-numbertoggle'
"Plugin 'Valloric/YouCompleteMe'
"Plugin 'Rip-Rip/clang_complete'


call vundle#end()            " required
filetype plugin indent on    " required

"buffer screen updates instead of updating all the time
set lazyredraw

" Trigger configuration. Do not use <tab> if you use
"https://github.com/Valloric/YouCompleteMe.
set omnifunc=syntaxcomplete#Complete
set completeopt-=preview
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

let g:loaded_youcompleteme = 1
nnoremap <leader>y :let g:ycm_auto_trigger=0<CR>                " turn off YCM
nnoremap <leader>Y :let g:ycm_auto_trigger=1<CR>                "turn on YCM


"for neocomplete
"Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|public$\|log$\|tmp$\|vendor$',
  \ 'file': '\v\.(exe|so|dll)$'
\ }

" "Syntastic option
 set statusline+=%#warningmsg#
 set statusline+=%{SyntasticStatuslineFlag()}
 set statusline+=%*
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0

if executable('ag')
    let g:ackprg = "ag --nogroup --column"
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

nnoremap ,ag :Ag! --ignore tags --ignore cscope.out  


"color scheme
syntax enable
set background=dark
colorscheme solarized
"colorscheme desert-warm-256

"air line top
let g:airline#extensions#tabline#enabled = 1
"set AirlineTheme solarized "call it once
let g:airline_solarized_bg='dark'
let g:airline_theme='laederon'

nmap <leader>] :bnext<CR>
nmap <leader>[ :bprevious<CR>
nmap <leader>o :enew<CR>
nmap <leader>p :bp <BAR> bd #<CR>

"basic settings
set nu
set ai
set ts=8
set sw=8
set sts=8
set cc=80
set hlsearch
highlight Visual cterm=NONE ctermbg=3 ctermfg=1 guibg=Grey40

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

"set white space
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
nmap <F12> :call Whitespace()<CR>
" augroup Whitespace
"     autocmd!
"     autocmd BufEnter,WinEnter * call Whitespace()
" augroup END
function! Maketags()
	call system("/home/hongiee/ctag.sh")
endfunction
nmap ,tag :call Maketags()<CR>

imap kj <Esc>

"CSCOPE settings
set csprg=/usr/bin/cscope
set csto=0               
set cst               
set nocsverb        
set csverb         
set csre

"set Mark.vim palette color
set t_Co=256
"set vim background color good in tmux
set t_ut=
let g:mwDefaultHighlightingPalette = 'maximum'
nmap <Leader>n <Plug>MarkAllClear
"let g:solarized_termcolors=256
"nmap * <Plug>MarkSearchOrCurNext
"nmap # <Plug>MarkSearchOrCurPrev

"Taglist settings
filetype on
let Tlist_Ctags_Cmd="/usr/bin/ctags"
let Tlist_Inc_winwidth = 0
let Tlist_Exit_OnlyWindow=0
let Tlist_Auto_Open=0
let Tlist_Use_Right_Window=0

"Source Explorer
nmap <C-H> <C-W>h
nmap <C-J> <C-W>j
nmap <C-K> <C-W>k
nmap <C-L> <C-W>l
set splitright
set splitbelow

nmap <leader>o :enew<CR>

let g:SrcExpl_winHeigh=8
let g:SrcExpl_refreshTime=100
let g:SrcExpl_jumpkey= "<ENTER>"
let g:SrcExpl_gobackKey= "<SPACE>"
let g:SrcExpl_isUpdateTags = 0

"NERD Tree
let NERDTreeWinPos ="right"

"Taglist settings
filetype on
let Tlist_Ctags_Cmd="/usr/bin/ctags"
let Tlist_Inc_winwidth = 0
let Tlist_Exit_OnlyWindow=0
let Tlist_Auto_Open=0
let Tlist_Use_Right_Window=0

set tags=./tags;,tags;
"trinity source insight
"
"nmap <F7> :TrinityToggleAll<CR>

nmap <F7> :TlistToggle<CR>

nmap <F8> :SrcExplToggle<CR>

nmap <F9> :NERDTreeToggle<CR>
nmap ,ner :NERDTreeToggle<CR>

"tabsize  ls명령이 파일 버퍼들 보는것임
map ,1 :b!1<CR> "1번 파일 버퍼로 이동 
map ,2 :b!2<CR> 
map ,3 :b!3<CR> 
map ,4 :b!4<CR> 
map ,5 :b!5<CR> 
map ,6 :b!6<CR> 
map ,7 :b!7<CR> 
map ,8 :b!8<CR> 
map ,9 :b!9<CR> 
map ,0 :b!0<CR> 
map ,x :bn!<CR>  "다음 파일 버퍼 
map ,y :bp!<CR> 
map ,w :bw<CR>  "현재 파일 버퍼를 닫음

"cscope
func! Css()
	let css = expand("<cword>")
	new
	exe "cs find s ".css
	if getline(1) == ""
		exe "1!"
	endif
endfunc
nmap ,css :call Css()<cr>

func! Csc()
	let csc = expand("<cword>")
	new
	exe "cs find c ".csc
	if getline(1) == ""
		exe "q!"
	endif
endfunc
nmap ,csc :call Csc()<cr>


func! Csg()
	let csg = expand("<cword>")
	new
	exe "cs find g ".csg
	if getline(1) == ""
		exe "q!"
	endif
endfunc
nmap ,csg :call Csg()<cr>


