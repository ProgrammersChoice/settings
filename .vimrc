"todo is change zshrc, ag, ctags, fugitive, gitgutter, 자동완성
"tmux keys
"tmux cpy : <prefix> [ to copy mode
"tmux close pane : <prefix> x
"
"
set nocompatible              " be improved, required
filetype off                  " required

"http://klutzy.nanabi.org/blog/2014/08/11/uses-this/
" set the runtime path to include Vundle and initialize
"설치할 플러긴을 begin 과 end 사이에 설치

set cb=unnamed " 윈도우에서 복사하기 위해 *레지스터 이용 +가 기본

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
" Search [:PluginSearch]  install is [:PluginInstall]  to delete erase from here and type [:PluginClean]
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'vim-airline/vim-airline' "bottom line pretty
Plugin 'vim-airline/vim-airline-themes' "bottom line pretty
Plugin 'airblade/vim-gitgutter' "see the changes for git
Plugin 'tpope/vim-fugitive' "using git [Gstatus] [Gdiff] [Gblame] [Glog] [q:cprev [Q:cfirst ]q:cnext ]Q:clast
Plugin 'unimpaired.vim' "using glog -> [q : cprev ...
"Glog -10, Glog -1- --reverse
Plugin 'scrooloose/syntastic' "code error conventions
Plugin 'ctrlpvim/ctrlp.vim' "[ctrl+p] 파일 찾기, [C-p] [C-t] [C-v] [C-x]
Plugin 'rking/ag.vim' "v, h, t, go
Plugin 'mileszs/ack.vim'
Plugin 'tpope/vim-surround' "cs'] cSw] csw] ysiw] yss] ds) VS]
Plugin 'kshenoy/vim-signature' "ma <- marking ma<-delete, m/(list)
Plugin 'tpope/vim-dispatch'
Plugin 'oblitum/rainbow' "different color () [rainbowtoggle]
Plugin 'tpope/vim-commentary' "쉬운 주석  [gcap],[gcc], [선택 gc] , [7,17Commentary], [g/TODO/Commentary]
"Plugin 'christoomey/vim-tmux-navigator'
"Plugin 'taglist-plus'
Plugin 'Logcat-syntax-highlighter' "android logcat syntax
Plugin 'Source-Explorer-srcexpl.vim'
Plugin 'dzeban/vim-log-syntax'
Plugin 'tpope/vim-repeat'
Plugin 'Yggdroot/vim-mark' "색칠 [\m] [\n]
"Plugin 'vmark.vim--Visual-Bookmarking'


" color scheme  
" vimcolors.com   
"Plugin 'flazz/vim-colorschemes' "각종 컬러
Plugin 'altercation/vim-colors-solarized'
"Plugin 'desert-warm-256'
Plugin 'kchmck/vim-coffee-script'
"Plugin 'Lokaltog/vim-powerline.git'


"fast coding tools
"Track the engine.

" Snippets are separated from the engine. Add this if you want them:
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'Lokaltog/vim-easymotion' "\\s \\k \\j \\w \\b
Plugin 'vim-scripts/SyntaxComplete'
"Plugin 'Shougo/neocomplete.vim'
Plugin 'Valloric/YouCompleteMe'
""
Plugin 'jeffkreeftmeijer/vim-numbertoggle'
"Plugin 'Rip-Rip/clang_complete'


call vundle#end()            " required
filetype plugin indent on    " required
filetype plugin on "required

let g:Powerline_symbols = 'fancy'
set laststatus=2 " 상 태바 표시를 항상 함


"buffer screen updates instead of updating all the time
"set lazyredraw

" Trigger configuration. Do not use <tab> if you use
"https://github.com/Valloric/YouCompleteMe.
set omnifunc=syntaxcomplete#Complete
set completeopt-=preview
set backspace=indent,eol,start


" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

let g:loaded_youcompleteme = 1
nnoremap <leader>y :let g:ycm_auto_trigger=0<CR>                " turn off YCM
nnoremap <leader>Y :let g:ycm_auto_trigger=1<CR>                "turn on YCM


"for neocomplete
"Disable AutoComplPop.
"let g:acp_enableAtStartup = 0
" Use neocomplete.
"let g:neocomplete#enable_at_startup = 1
" Use smartcase.
"let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
"let g:neocomplete#sources#syntax#min_keyword_length = 3

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
let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp ='[^.[:digit:] *\t]\%(\.\|\-)\|\h\w*:'



"for rainbow plugin
au FileType c,cpp,objc,objcpp call rainbow#load()

"setting for syntaxcomplete => setup syntaxcomplete for every filetype
if has("autocmd") && exists("+omnifunc")
	autocmd Filetype *
			\    if &omnifunc == "" |
			\        setlocal omnifunc=syntaxcomplete#Complete |
			\    endif
endif

"
"[speed up ag]
"[speed up ag]
"[speed up ag]

if executable('ag')
    let g:ackprg = "ag --nogroup --column"
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

nnoremap ,ag :Ag! --ignore tags --ignore cscope.out  
nnoremap ,ac :Ag!

"
"[settings for ultisnips]
"[settings for ultisnips]
"[settings for ultisnips]
":UltiSnipsEdit is make custom stnips for that workspace
" "Trigger configuratio. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe. 
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" prevent Ultisnips from removing our carefully-crafted mappings.
let g:UltiSnipsMappingsToIgnore = ['autocomplete']
   
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
  
"c랑 cpp c#지원 위해 ~/.vim/bundle/YouCompleteMe/install.py --clang-completer --omnisharp-completer 실행해줘야함.
"[settings for YCM YouCommpleteMe]
"[settings for YCM YouCommpleteMe]
"[settings for YCM YouCommpleteMe]
"https://github.com/Valloric/ycmd/blob/master/cpp/ycm/.ycm_extra_conf.py 를 아래 경로에 복사해둠
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/.ycm_extra_conf.py'
let g:ycm_server_python_interpreter = '/usr/bin/python3'
 
" 기본값은 1입니다.'.'이나 '->'을 받으면 자동으로 목록들을 출력해주죠.
let g:ycm_confirm_extra_conf = 1
let g:ycm_key_list_select_completion = ['<C-j>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-k>', '<Up>']
let g:ycm_key_list_accept_completion = ['<C-y>','']
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_warning_symbol = '>*'
nnoremap <leader>g :YcmCompleter GoTo
nnoremap <leader>gg :YcmCompleter GoToImprecise
nnoremap <leader>d :YcmCompleter GoToDeclaration
nnoremap <leader>t :YcmCompleter GetType
nnoremap <leader>p :YcmCompleter GetParent 
                
let g:ycm_complete_in_comments = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_seed_identifiers_with_sytax = 1 "기본값은 2이며 문자가넘어오면 자동으로시작
let g:ycm_auto_trigger = 1 "YCM이 자동으로시작할지ctrl + space로 시작할지
let g:ycm_min_num_of_chars_for_completion = 1 
let g:ycm_server_keep_logfiles = 1
let g:ycm_server_log_level ='debug'
let g:ycm_collect_identifiers_from_tags_files = 1 " tags 파일을 사용합니다. 성능상 이익이 있는걸로 알고있습니다.
let g:ycm_filetype_whitelist = { '*': 1 }
let g:ycm_filetype_blacklist = {
	\ 'tagbar' : 1,
	\ 'qf' : 1,
	\ 'notes' : 1,
	\}

"
"[NERDTree setting defaults to work around]
"[NERDTree setting defaults to work around]
"[NERDTree setting defaults to work around]
" http://github.com/scrooloose/nerdtree/issues/489
let g:NERDTreeDirArrows = 1
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '◂'
let g:NERDTreeGlyphReadOnly = "RO"

"
"[set Mark.vim palette color]
"[set Mark.vim palette color]
"[set Mark.vim palette color]
nmap <Leader>n <Plug>MarkAllClear


"
"[air line top]
"[air line top]
"[air line top]
let g:airline#extensions#tabline#enabled = 1
"set AirlineTheme solarized "call it once
let g:airline_solarized_bg='dark'
let g:airline_theme='laederon'

nmap <leader>] :bnext<CR>
nmap <leader>[ :bprevious<CR>
nmap <leader>o :enew<CR>
nmap <leader>p :bp <BAR> bd #<CR>

"
"[Syntastic option]
"[Syntastic option]
"[Syntastic option]
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
 " let g:syntastic_always_populate_loc_list = 1
 " let g:syntastic_auto_loc_list = 1
 " let g:syntastic_check_on_open = 1
 " let g:syntastic_check_on_wq = 0

"
"[general Vim Setting]
"[general Vim Settings]
"[general Vim Settings]
syntax enable
colorscheme solarized
"filetype plugin indent on
"set t_Co=16
set t_Co=256
let g:mwDefaultHighlightingPalette = 'maximum'
set background=dark
let g:solarized_termcolors=256

set autoindent
set cindent
set tabstop=8 "tab을 8개의 공백으로
set shiftwidth=8 " 들여쓰기시 기본 공백 크기
set nu
set ai
set ts=8
set sw=4
set sts=4
"set cc=80
set hlsearch
imap kj <Esc>
"highlight Visual cterm=NONE ctermbg=3 ctermfg=1 guibg=Grey40
highlight ColorColumn ctermbg=6 guibg=LightSeaGreen
highlight Visual ctermfg=3

"
"[CTag settings]
"[CTag settings]
"[CTag settings]
set tags=./tags;
"하위로 이동하면서 tag찾기
function SetTags()
    let curdir = getcwd()

    while !filereadable("tags") && getcwd() != "/"
	cd..
    endwhile
    if filereadable("tags")
	execute "set tags=".getcwd()."/tags"
    endif
    execute "cd " . curdir
endfunction
call SetTags()

function Maketags()
    call system("~/make_tags.sh")
endfunction

function Addtags()
    call system("~/tags.sh")
endfunction

nmap ,tag :call Addtags()<CR>
nmap ,ctag :call Maketags()<CR>
"arch=arm version

"
"[CSCOPE settings]
"[CSCOPE settings]
"[CSCOPE settings]
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

"
"[Taglist settings]
"[Taglist settings]
"[Taglist settings]
filetype on
let Tlist_Ctags_Cmd="/usr/bin/ctags"
let Tlist_Inc_winwidth = 0
let Tlist_Exit_OnlyWindow=0
let Tlist_Auto_Open=0
let Tlist_Use_Right_Window=0

"
"[Source Explorer]
"[Source Explorer]
"[Source Explorer]
nmap <C-H> <C-W>h
nmap <C-J> <C-W>j
nmap <C-K> <C-W>k
nmap <C-L> <C-W>l

let g:SrcExpl_winHeight=8
let g:SrcExpl_refreshTime=100
let g:SrcExpl_jumpKey= "<ENTER>"
let g:SrcExpl_gobackKey= "<SPACE>"
let g:SrcExpl_isUpdateTags = 0

"
"[set white space]
"[set white space]
"[set white space]
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
nmap ,tag :call Maketags()<CR>

"
"[NERD Tree]
"[NERD Tree]
"[NERD Tree]
let NERDTreeWinPos ="right"

"trinity source insight
"
"nmap <F7> :TrinityToggleAll<CR>

nmap <F7> :TlistToggle<CR>

nmap <F8> :SrcExplToggle<CR>

nmap <F9> :NERDTreeToggle<CR>
nmap ,m :NERDTreeToggle<CR>

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

"[cscope]
"[cscope]
"[cscope]
func! Css()
	let css = expand("<cword>")
	new
	exe "cs find s ".css
	if getline(1) == ""
		exe "q!"
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

