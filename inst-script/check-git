#!/bin/bash
#
# gitコマンドをチェック
#
if [ "`which git`" = "" ]; then
  echo
  echo gitコマンドがインストールされていません。
  echo gitコマンドをインストールしてから再度実行してください。
  echo 処理を終了します。
  exit 1
else
  GIT_VER=`git --version | cut -c 13-15`
  # 古いgitのときはアップグレード
  if [ `echo "${GIT_VER} >= 1.9" | bc` = 0 ]; then
    if [ ${ALM_GIT_AUTO_UPGRADE} = 'y' ]; then
      GIT_UPDATE=y
    else
      echo
      echo
      echo gitのバージョンが古いためALMiniumが正しく動作しない可能性があります。
      echo 本ソフトウェアでは version1.9以上を推奨しています。
      echo gitのバージョンを${ALM_GIT_VERSION}にアップグレードしても良い場合は'y'を
      echo さもなくば'N'を選択してください。
      echo 'N'を選択した場合は、ALMiniumインストールした後、
      echo ご自身でgitのバージョンアップを実施してください。
      echo -n "gitをアップグレードしても良いですか？(y/N):"
      read GIT_UPDATE
    fi
  fi
fi
