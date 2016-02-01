"************************************************
"  NeoBundle Set-up
"************************************************
if 0 | endif

if has('vim_starting')
  if &compatible
    set nocompatible
  endif
  set runtimepath+=/home/vagrant/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('/home/vagrant/.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'

" 導入プラグインリスト
NeoBundle 'tomasr/molokai'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'Townk/vim-autoclose'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'marcus/rsense'
NeoBundle 'bling/vim-airline'
NeoBundle 'tpope/vim-endwise'
NeoBundle 'thinca/vim-ref'
NeoBundle 'yuku-t/vim-ref-ri'
NeoBundle 'szw/vim-tags'
NeoBundle 'bronson/vim-trailing-whitespace'

NeoBundle 'Shougo/vimproc.vim', {
  \ 'build' : {
    \ 'mac' : 'make -f make_mac.mak',
    \ 'unix': 'gmake -f make_unix.mak',
    \ 'linux': 'make',
    \ 'windows': 'make -f make_mingw32.mak',
    \},
  \}

NeoBundleLazy 'supermomonga/neocomplete-rsense.vim', { 'autoload' : {
  \ 'insert' : 1,
  \ 'filetypes': 'ruby',
  \ }}

call neobundle#end()

NeoBundleCheck

"***********************************************s
"  neocomplete.vim
"************************************************
let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
if !exists('g:neocomplete#force_omni_input_patterns')
  let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_omni_input_patterns.ruby = '[^.*\t]\.\w*\|\h\w*::'

" dicts(ruby)
let g:neocomplete#sources#dictionary#dictionaries = {
\   'ruby': $HOME . '/dicts/ruby.dict',
\ }

" Ctrl＋eで補完を強制終了
inoremap <expr><C-d> neocomplete#cancel_popup()

"************************************************
"  rsense.vim
"************************************************
let g:rsenseHome = '/usr/local/lib/rsense-0.3'
let g:rsenseUseOmniFunc = 1

"************************************************
"  キーマップ・ショートカット設定
"************************************************
" ファイル保存時のsudo忘れ対策
nmap ,sudo :w !sudo tee %<CR>

" [F3] でNERDTree起動
nnoremap <F3> :NERDTreeToggle<CR>

" [space + "."] で.vimrcを開く
nnoremap <space>. :<C-u>tabedit $MYVIMRC<CR>

" [+/-] でインクリメント/デクリメント実行
nnoremap + <C-a>
nnoremap - <C-x>

" [shift + c] でNERD commenter作動（コメントorコメントアウト）
let NERDSpaceDelims = 1
"let g:NERDCustomDelimiters = {
"    \ 'ruby' : {'left': '#'}
"}
nmap <S-c> <plug>NERDCommenterToggle
vmap <S-c> <plug>NERDCommenterToggle

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

"************************************************
"  挙動設定
"************************************************
" カーソルハイライト
set cursorline
hi clear CursorLine

" 自動折り返し対応（window長超えた時のみ折り返し）
set textwidth=0

" Backspaceで行頭削除許可
set backspace=indent,eol,start

" クリップボードを連携
set clipboard+=unnamed

" 括弧対応
set nostartofline
set showmatch
set matchtime=2

" ビープ音消去
set vb t_vb=

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

"************************************************
"  vim基本設定
"************************************************
" 文字設定
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
let g:airline_left_sep = "\u2b80"
let g:airline_left_alt_ep = "\u2b80"
let g:airline_right_sep = "\u2b82"
let g:airline_right_alt_sep = "\u2b82"
"let g:airline_branch_prefix = '⭠ '
let g:airline#extensions#readonly#symbol = '⭤ '
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
