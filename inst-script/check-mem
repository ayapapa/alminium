#!/bin/bash
# check memory size
MEM=`free -t | grep Total | awk '{print $2}'`
if [ ${MEM} -lt 1000000 ]; then
  echo "メモリが不足しています。"
  echo "ALMiniumのインストールは1GB以上のRAMが利用できるマシン及び仮想マシンに"
  echo "インストールしてください"
  exit 1
fi

