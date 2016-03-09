" ============neobundle用設定============

" neobundle settings {{{
if has('vim_starting')
  set nocompatible
  " neobundle をインストールしていない場合は自動インストール
  if !isdirectory(expand("~/.vim/bundle/neobundle.vim/"))
    echo "install neobundle..."
    " vim からコマンド呼び出しているだけ neobundle.vim のクローン
    :call system("git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim")
  endif
  " runtimepath の追加は必須
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
call neobundle#begin(expand('~/.vim/bundle'))
let g:neobundle_default_git_protocol='https'

" neobundle#begin - neobundle#end の間に導入するプラグインを記載します。
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'nanotech/jellybeans.vim'

NeoBundle 'Shougo/vimproc', {
  \ 'build' : {
  \     'windows' : 'make -f make_mingw32.mak',
  \     'cygwin' : 'make -f make_cygwin.mak',
  \     'mac' : 'make -f make_mac.mak',
  \     'unix' : 'make -f make_unix.mak',
  \    },
  \ }

NeoBundle 'Townk/vim-autoclose'

NeoBundleLazy 'tpope/vim-endwise', {
  \ 'autoload' : { 'insert' : 1,}}

NeoBundleLazy 'AndrewRadev/switch.vim'

" switch {{{
nmap + :Switch<CR>
nmap - :Switch<CR>
" }}}

if has('lua')
  NeoBundleLazy 'Shougo/neocomplete.vim', {
    \ 'depends' : 'Shougo/vimproc',
    \ 'autoload' : { 'insert' : 1,}
    \ }
endif

" neocomplete {{{
let g:neocomplete#enable_at_startup               = 1
let g:neocomplete#auto_completion_start_length    = 3
let g:neocomplete#enable_ignore_case              = 1
let g:neocomplete#enable_smart_case               = 1
let g:neocomplete#enable_camel_case               = 1
let g:neocomplete#use_vimproc                     = 1
let g:neocomplete#sources#buffer#cache_limit_size = 1000000
let g:neocomplete#sources#tags#cache_limit_size   = 30000000
let g:neocomplete#enable_fuzzy_completion         = 1
let g:neocomplete#lock_buffer_name_pattern        = '\*ku\*'
" }}}

" Ruby on rails
NeoBundleLazy 'tpope/vim-rails'

" Ruby
NeoBundleLazy 'vim-ruby/vim-ruby', {
  \ 'autoload' : {'filetypes' : ['ruby', 'eruby']}}

NeoBundleLazy 'NigoroJr/rsense'
NeoBundleLazy 'supermomonga/neocomplete-rsense.vim', {
    \ 'autoload' : { 'insert' : 1, 'filetype' : 'ruby', } }

" 補完の設定
if !exists('g:neocomplete#force_omni_input_patterns')
  let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_omni_input_patterns.ruby = '[^.*\t]\.\w*\|\h\w*::'
let g:rsenseUseOmniFunc = 1

" 静的解析
NeoBundleLazy 'scrooloose/syntastic'

" ドキュメント参照
NeoBundleLazy 'thinca/vim-ref'
NeoBundleLazy 'yuku-t/vim-ref-ri'

" メソッド定義元へのジャンプ
NeoBundleLazy 'szw/vim-tags'

" html
NeoBundleLazy 'hail2u/vim-css3-syntax'
NeoBundleLazy 'othree/html5.vim'

" javascript
NeoBundleLazy 'kchmck/vim-coffee-script'
NeoBundleLazy 'moll/vim-node'
NeoBundleLazy 'pangloss/vim-javascript'

" Markdown
NeoBundleLazy 'rcmdnk/vim-markdown'
" vim-markdown {{{
let g:vim_markdown_folding_disabled = 1
" }}}

NeoBundleLazy 'kannokanno/previm'
NeoBundleLazy 'tyru/open-browser.vim'

au BufRead,BufNewFile *.md set filetype=markdown
let g:previm_open_cmd = 'open'

NeoBundleLazy 'thinca/vim-quickrun'

" vimrc に記述されたプラグインでインストールされていないものがないかチェックする
NeoBundleCheck
call neobundle#end()
filetype plugin indent on

" どうせだから jellybeans カラースキーマを使ってみましょう
set t_Co=256
syntax on
colorscheme jellybeans

" ============neobundle用設定============


set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  set undofile		" keep an undo file (undo changes after closing)
endif

set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" Don't use Ex mode, use Q for formatting
map Q gq

set hlsearch

set autoindent		" always set autoindenting on
set smartindent

set number
set expandtab
set tabstop=2
set shiftwidth=2
set showmatch
set backupdir=/tmp
set undodir=/tmp

" ファイル形式の検出の有効化する
" ファイル形式別プラグインのロードを有効化する
" ファイル形式別インデントのロードを有効化する
filetype plugin indent on

noremap <C-j> <esc>
noremap! <C-j> <esc>

" Turn off paste mode when leaving insert mode
autocmd InsertLeave * set nopaste

"バイナリ編集(xxd)モード（vim -b での起動、もしくは *.bin ファイルを開くと発動します）
augroup BinaryXXD
  autocmd!
  autocmd BufReadPre  *.bin let &binary =1
  autocmd BufReadPost * if &binary | silent %!xxd -g 1
  autocmd BufReadPost * set ft=xxd | endif
  autocmd BufWritePre * if &binary | %!xxd -r | endif
  autocmd BufWritePost * if &binary | silent %!xxd -g 1
  autocmd BufWritePost * set nomod | endif
augroup END

