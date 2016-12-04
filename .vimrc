set encoding=utf-8
set fileencoding=utf-8

" ===== Config of dein.vim START =====
" Refer to : http://qiita.com/delphinus/items/00ff2c0ba972c6e41542

" reset augroup
" Refer to : http://qiita.com/kawaz/items/ee725f6214f91337b42b
augroup MyAutoCmd
  autocmd!
augroup END

" プラグインが実際にインストールされるディレクトリ
let s:dein_dir = expand('~/.cache/dein')
" dein.vim 本体
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" dein.vim がなければ github から落としてくる
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

" 設定開始
if dein#load_state(s:dein_dir)
  " プラグインリストを収めた TOML ファイル
  " 予め TOML ファイルを用意しておく
  let g:rc_dir    = expand('~/.vim/rc')
  let s:toml      = g:rc_dir . '/dein.toml'
  let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'

  call dein#begin(s:dein_dir, [$MYVIMRC, s:toml])

  " TOML を読み込み、キャッシュしておく
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  " 設定終了
  call dein#end()
  call dein#save_state()
endif

" Install not installed plugins on startup
if dein#check_install()
  call dein#install()
endif
" ===== Config of dein.vim END =====

set t_Co=256
syntax on

set backspace=indent,eol,start

if has("vms")
  set nobackup    " do not keep a backup file, use versions instead
else
  set backup    " keep a backup file (restore to previous version)
  set undofile    " keep an undo file (undo changes after closing)
endif

set history=50    " keep 50 lines of command line history
set ruler   " show the cursor position all the time
set showcmd   " display incomplete commands
set incsearch   " do incremental searching

" Don't use Ex mode, use Q for formatting
map Q gq

set hlsearch

set autoindent    " always set autoindenting on
set smartindent

set number
set expandtab
set tabstop=2
set shiftwidth=2
set showmatch

let s:tmp_dir = '/tmp'
exec "set directory=" . s:tmp_dir
exec "set undodir=" . s:tmp_dir
exec "set backupdir=" . s:tmp_dir

" ref : http://vim-jp.org/vim-users-jp/2011/02/20/Hack-202.html
augroup vimrc_auto_mkdir  " {{{
  autocmd!
  autocmd BufWritePre * call s:auto_mkdir(s:tmp_dir)
  function! s:auto_mkdir(dir)  " {{{
    if !isdirectory(a:dir)
      call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
    endif
  endfunction  " }}}
augroup END  " }}}

" ファイル形式の検出の有効化する
" ファイル形式別プラグインのロードを有効化する
" ファイル形式別インデントのロードを有効化する
filetype plugin indent on

syntax enable

noremap <C-j> <esc>
noremap! <C-j> <esc>
nnoremap <Tab> <C-w>w

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

set cursorline

highlight Search cterm=reverse ctermbg=none

set list
set listchars=tab:»-,trail:-,nbsp:%

set clipboard& clipboard+=unnamed   " Yankしたらクリップボードへ

" Automatically set paste
if &term =~ "xterm"
  let &t_ti .= "\e[?2004h"
  let &t_te .= "\e[?2004l"
  let &pastetoggle = "\e[201~"

  function XTermPasteBegin(ret)
    set paste
    return a:ret
  endfunction

  noremap <special> <expr> <Esc>[200~ XTermPasteBegin("0i")
  inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
  cnoremap <special> <Esc>[200~ <nop>
  cnoremap <special> <Esc>[201~ <nop>
endif

