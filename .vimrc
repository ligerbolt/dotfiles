" --------------------------------------------------
"    dein.vim
" --------------------------------------------------
if &compatible
  set nocompatible
endif

" let $PATH = "~/.pyenv/shims:".$PATH

" Vim起動時にインストール
augroup Pjedi-vimluginInstall
  autocmd!
  autocmd VimEnter * if dein#check_install() | call dein#install() | endif
augroup END

" インストールディレクトリ
set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim

" 導入プラグイン一覧
call dein#begin(expand('~/.vim/dein/'))

call dein#add('Shougo/dein.vim')
call dein#add('Shougo/vimproc.vim', {'build': 'make'})
call dein#add('Shougo/unite.vim')
call dein#add('Shougo/neomru.vim')

call dein#add('tomasr/molokai', {'merged': 0})
call dein#add('bling/vim-airline')

call dein#add('scrooloose/nerdtree')
call dein#add('scrooloose/nerdcommenter')
call dein#add('Townk/vim-autoclose')
call dein#add('bronson/vim-trailing-whitespace')
call dein#add('tpope/vim-endwise')

"call dein#add('davidhalter/jedi-vim')

call dein#add('othree/html5.vim')
call dein#add('slim-template/vim-slim')

call dein#add('derekwyatt/vim-scala')

if has('lua')
  call dein#add('Shougo/neocomplete.vim', {
    \ 'on_i': 1,
    \ 'lazy': 1})
endif

call dein#end()

" プラグイン未インストールチェック
if dein#check_install()
  call dein#install()
endif


" --------------------------------------------------
"    neocomplete.vim
" --------------------------------------------------
let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplcache_min_syntax_length = 3
if !exists('g:neocomplete#force_omni_input_patterns')
  let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_omni_input_patterns.ruby = '[^.*\t]\.\w*\|\h\w*::'
let g:neocomplete#force_omni_input_patterns.python = '[^. \t]\.\w*'
set completeopt=menuone


" 辞書参照設定
let g:neocomplete#sources#dictionary#dictionaries = {
 \   'ruby': $HOME . '/dicts/ruby.dict',
 \   'javascript': $HOME . '/dicts/javascript.dict',
 \   'vimshell': $HOME . '.vimshell_hist',
 \   'python': $HOME . '/dicts/python_ver3.5.dict',
 \ }

" Ctrl+r で直前の補完キャンセル＆補完文字削除
inoremap <expr><C-r>     neocomplete#undo_completion()

" Ctrl+l で補完候補で共通部を補完
inoremap <expr><C-l>     neocomplete#complete_common_string()

" tab で候補選択
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" BS or Ctrl+h で保管用ポップアップ削除
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"

" Ctrl＋d で補完を強制終了
inoremap <expr><C-d> neocomplete#cancel_popup()

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" --------------------------------------------------
"     キーマップ＆ショートカット設定
" --------------------------------------------------
" ファイル保存時のsudo忘れ対策
nmap ,sudo :w !sudo tee %<CR>

" [F2] でシェル切り替え
nnoremap <F2> :shell<CR>

" [F3] でNERDTree起動
nnoremap <F3> :NERDTreeToggle<CR>

" [space + "."] で.vimrcを開く
nnoremap <space>. :<C-u>tabedit $MYVIMRC<CR>

" ,, でNERD commenter作動（コメントorコメントアウト）
let NERDSpaceDelims = 1
"let g:NERDCustomDelimiters = {
"    \ 'ruby' : {'left': '#'}
"}
nmap ,, <plug>NERDCommenterToggle
vmap ,, <plug>NERDCommenterToggle

" 矢印キー設定追加(画面移動)
noremap <Up> gk
noremap <Down> gj
noremap <S-Up> <C-u>
noremap <S-Down> <C-d>
noremap <C-Up> gg
noremap <C-Down> G

" bash風キーマップ設定
noremap <C-a> 0
noremap <C-e> $

" ハイライト表示消去
noremap <ESC><ESC> :noh<CR>


" --------------------------------------------------
"     jedi-vim設定
" --------------------------------------------------
"autocmd FileType python setlocal omnifunc=jedi#completions
"let g:jedi#completions_enabled = 0
"let g:jedi#auto_vim_configuration = 0
"if !exists('g:neocomplete#force_omni_input_patterns')
"  let g:neocomplete#force_omni_input_patterns = {}
"endif

"let g:neocomplete#force_omni_input_patterns.python = '\h\w*\|[^. \t]\.\w*'


" --------------------------------------------------
"     html5.vim設定
" --------------------------------------------------
let g:html5_event_handler_attributes_complete = 1
let g:html5_rdfa_attributes_complete = 1
let g:html5_microdata_attributes_complete = 1
let g:html5_aria_attributes_complete = 1


" --------------------------------------------------
"     scala-vim
" --------------------------------------------------
au BufNewFile,BufRead *.scala setf scala
au BufNewFile,BufRead *.sbt setf scala


" --------------------------------------------------
"     vim 基本設定
" --------------------------------------------------
set encoding=utf-8
set fileencodings=utf-8,iso-2022-jp,euc-jp,sjis
set fileformats=unix,dos,mac

" シンタックス設定
syntax on
colorscheme molokai
highlight Normal ctermbg=none
filetype plugin on
filetype indent on

" カラー設定(ポップアップメニュー含)
hi Pmenu ctermbg=4 ctermfg=white
hi PmenuSel ctermbg=6 ctermfg=white

" ステータスバー設定
set noshowmode
" let g:lightline = {
      " \ 'colorscheme': 'landscape',
      " \ 'component': {
      " \   'readonly': '%{&readonly?"⭤":""}',
      " \ },
      " \ 'separator': { 'left': "\u2b80", 'right': "\u2b82" },
      " \ 'subseparator': { 'left': "\u2b81", 'right': "\u2b83" }
      " \ }
let g:airline_left_sep = ""
let g:airline_left_alt_ep = ""
let g:airline_right_sep = ""
let g:airline_right_alt_sep = ""
"let g:airline_branch_prefix = '⭠ '
let g:airline#extensions#readonly#symbol = ''
set laststatus=2
set t_Co=256

" カーソル行より下の最低行表示数
set scrolloff=5

" 行の折り返し表示許可
set wrap

" ルーラ表示
set ruler

" 行番号表示
set number
hi LineNr ctermfg=white
hi CursorLineNr ctermbg=gray ctermfg=yellow

" コメント表示色指定
highlight Comment ctermfg=yellow

" タブ設定
set tabstop=2
set shiftwidth=2
set softtabstop=0
set expandtab

" インデント設定
set smartindent
set autoindent
set cindent

" 検索設定
set hlsearch
set incsearch
set ignorecase
set smartcase

" ターミナル接続高速化
set ttyfast

" コマンド履歴設定
set history=100

" swpファイル作成しない
set noswapfile

" ビープ音消去
set vb t_vb=


" --------------------------------------------------
"     vim 基本設定
" --------------------------------------------------
" カーソルハイライト
set cursorline
hi clear CursorLine

" 自動折り返し対応（window長超えた時のみ折り返し）
set textwidth=0

" Backspaceで行頭削除許可
set backspace=indent,eol,start

" クリップボードを連携
set clipboard=unnamed,autoselect

" 括弧対応
set nostartofline
set showmatch
set matchtime=2

" 複数同時編集対応
set hidden
set autoread

" 起動時IMEをOFFにする
set iminsert=0 imsearch=0

" 矩形選択時の移動制限解除
set virtualedit& virtualedit+=block

" カーソル移動の行頭、行末処理（前後行へ移動可）
set whichwrap=b,s,h,l,<,>,[,]

" vim-trailing-whitespace設定
" バッファ書込前にFixWhiteSpace実行
autocmd BufWritePre * :FixWhitespace
