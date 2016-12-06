#!/bin/bash

cd $(dirname $0)

file_list=$(cat << EOS
.vimrc
rc/dein.toml
rc/dein_lazy.toml
EOS
)

set -x

for f in $file_list
do
  dir=$HOME/$(dirname $f)
  mkdir -p $dir
  ln -is "$PWD/$f" $dir
done

