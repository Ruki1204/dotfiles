" neobundle settings {{{
if has('vim_starting')
  set nocompatible
  " neobundle をインストールしていない場合は自動インストール
  if !isdirectory(expand("~/.vim/bundle/neobundle.vim/"))
    echo "install neobundle..."
    " vim からコマンド呼び出している neobundle.vim のクローン
    :call system("git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim")
  endif
  " runtimepath の追加
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
call neobundle#begin(expand('~/.vim/bundle'))
let g:neobundle_default_git_protocol='https'

"-----------------------------------------------------------------------------"
"  ここからプラグインインストール 
"-----------------------------------------------------------------------------"
NeoBundleFetch 'Shougo/neobundle.vim'
  " 非同期処理(アップデート処理)
NeoBundle 'Shougo/vimproc', {
    \ 'build' : {
    \     'windows' : 'make -f make_mingw32.mak',
    \     'cygwin' : 'make -f make_cygwin.mak',
    \     'mac' : 'make -f make_mac.mak',
    \     'unix' : 'make -f make_unix.mak',
    \ }}

" コーディング中のプログラムをVimから起動
NeoBundle 'thinca/vim-quickrun'
  let g:quickrun_config={'*': {'split': ''}}
  let g:quickrun_config._={ 'runner':'vimproc',
    \       "runner/vimproc/updatetime" : 10,
    \       "outputter/buffer/close_on_empty" : 1,
    \ }

NeoBundle 'Shougo/vimshell'
NeoBundle 'Shougo/unite.vim'
  let g:unite_enable_start_insert=1
  let g:unite_source_history_yank_enable =1
  let g:unite_source_file_mru_limit = 200
  nnoremap <silent> ,uy :<C-u>Unite history/yank<CR>
  nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
  nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
  nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>
  nnoremap <silent> ,uu :<C-u>Unite file_mru buffer<cr>

NeoBundle 'Shougo/neomru.vim'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'tomasr/molokai'
NeoBundle 'mattn/emmet-vim'
  let g:user_emmet_leader_key='<c-e>'
  let g:user_emmet_settings = {
        \ 'lang' : 'ja',
        \ 'html' : {
        \   'filters' : 'html',
        \ },
        \ 'css' : {
        \   'filters' : 'fc',
        \ },
        \ 'php' : {
        \   'extends' : 'html',
        \   'filters' : 'html',
        \ },
        \}
  augroup EmmitVim
    autocmd!
    autocmd FileType * let g:user_emmet_settings.indentation = '               '[:&tabstop]
  augroup END

NeoBundle 'nathanaelkane/vim-indent-guides' "インデントに色を付ける
let g:indent_guides_auto_colors=0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd   ctermbg=147
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven  ctermbg=148
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_guide_size=1

NeoBundle 'itchyny/lightline.vim' "モードのビジュアル化
NeoBundle 'tyru/open-browser.vim' "ターミナルからブラウザを開く
  " カーソル下のURLをブラウザで開く
   nmap <Leader>o <Plug>(openbrowser-open)
   vmap <Leader>o <Plug>(openbrowser-open)
    nnoremap <space>g :<C-u>OpenBrowserSearch<Space><C-r><C-w><Enter>
" vimrc に記述されたプラグインでインストールされていないものがないかチェック
NeoBundleCheck
call neobundle#end()
filetype plugin indent on

"molokaiのカラースキーム有効
syntax on
colorscheme molokai
set t_Co=256

"-----------------------------------------------------------------------------"
"  基本設定 
"-----------------------------------------------------------------------------"
"Ctrl+Jでエスケープ（英数）
imap <c-j> <esc><jis_eisuu>
set clipboard+=unnamed "クリップボードをVim以外とも共有させる
set vb t_vb=           "ビープ音がならない
set backspace=indent,eol,start " バックスペースでなんでも消せるで
set iminsert=0 " insertモードで自動的にIMEがオンになるを防ぐ
set nomodeline " モードラインを有効にする
set modelines=0 " ３行目までモードラインとする
set nobackup " バックアップファイルは使わない
set noswapfile " スワップファイルは使わない
set hidden " 編集中でも他のファイルを開けるようになる
set confirm " 保存されていないファイルがあるときは終了時に確認
set autoread " 外部でファイルに変更があるときは読みなおす
set shellslash " セパレーターにスラッシュを利用可能にする
set noundofile "ホームにアンドゥファイルの作成ををしない

" ターミナルでマウスを有効にする
if has('mouse')
  set mouse=a
  set ttymouse=xterm2
endif

"matchitを有効化
if !exists('loaded_machit')
  runtime macros/matchit.vim
endif

"-----------------------------------------------------------------------------"
"   インデント
"-----------------------------------------------------------------------------"
set autoindent          " 前の行のインデント継続
set smartindent         " 開業時に入力された行の末尾に合わせて次の行のインデントを調節
set tabstop=2           " タブ入力時の空白の数
set shiftwidth=2        " 自動インデントの空白の数
set softtabstop=2       " キーボードでのtabの空白の数
set showtabline=2       " タブが２つ以上の場合、常に表示
set expandtab           " タブ入力を空白に変更 

"-----------------------------------------------------------------------------"
"   表示設定
"-----------------------------------------------------------------------------"
set notitle               "vimを使ってくれてありがとう
set shortmess+=I          "introの画面を出さないようにする
set laststatus=2          "statuslineを常に表示する
set showcmd               "コマンドをステータス行に表示
set ruler                 " ウィンドウのタイトルバーにファイルパス情報を表示
set number                " 行番号を表示
set showmatch             " 対応する括弧やプレースを表示
set listchars=trail:~     " 行末の半角スペースを表示する
set ambiwidth=double      " □や◯の文字があってもカーソル位置がずれないようにする
syntax on " シンタックスハイライト

"折り返し設定
set wrap
set whichwrap=b,s,h,l,[,],<,> "折り返し移動できるキーを指定

"カーソル関連
set cursorline " カーソル行の背景色を変更

"スクロール関連
set scrolloff=8 "上下視界８行を確保
set sidescrolloff=16 " 左右スクロールの視界を確保
set sidescroll=1  "左右スクロールを１行づつ

"不可視文字を表示する
set list
set listchars=tab:>-,trail:.,eol:$,extends:>,precedes:<,nbsp:%


"-----------------------------------------------------------------------------"
"   検索設定
"-----------------------------------------------------------------------------"
set incsearch " 検索ワードの最初の文字を入力した段階で検索を開始
set hlsearch " 検索結果をハイライト表示
set ignorecase " 検索で大文字小文字を区別しない
set smartcase " 検索で大文字小文字両方が入力されたら区別して検索
set wrapscan " 検索時にファイルの最後まで行ったら最初に戻る
set gdefault " 検索のときgオプションをデフォルトで有効にする

"-----------------------------------------------------------------------------"
"   ショートカット
"-----------------------------------------------------------------------------"
nnoremap sj :<C-w>j "分割画面を下に移動
nnoremap sk :<C-w>k "分割画面を上に移動
nnoremap sl :<C-w>l "右
nnoremap sh :<C-w>h "左
nnoremap ss :<C-u>sp<CR> "横分割
nnoremap sv :<C-u>vs<CR> "縦
nnoremap sq :<C-u>q<CR> "閉じる

