#!/bin/bash

cd $(dirname $0)

file_list=$(cat << EOS
.bashrc
.vimrc
.vim/rc/dein.toml
.vim/rc/dein_lazy.toml
EOS
)

set -x

for f in $file_list
do
  dir=$HOME/$(dirname $f)
  mkdir -p $dir
  ln -is "$PWD/$f" $dir
done

