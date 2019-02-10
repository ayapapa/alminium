#!/bin/bash
# rubygems.lstからgemのリストを取得しインストール

GEM=`which gem2.0`

if [ "${GEM}" = "" ]
then
  GEM=gem
fi

# gemの不具合(https://github.com/rubygems/rubygems/issues/2180#issuecomment-367147394)対応
# rubygem v2.7.7を待つ必要あるのでそれまでの暫定措置
GEM_VER=`gem env version`
if [ "${GEM_VER}" = "2.7.5" -o "${GEM_VER}" = "2.7.6" ]
then
  gem update --system  2.7.4
fi

# あらかじめインストールしておくrubygems
BUNDLER=bundle
NAME=(`grep -v "^#" inst-script/rubygems.lst | awk -F, '{print $1}'`)
VER=(`grep -v "^#" inst-script/rubygems.lst | awk -F, '{print $2}'`)

for (( i = 0; i < ${#NAME[@]}; ++i ))
do
  NAME=${NAME[$i]}
  VER=${VER[$i]}
  echo "**** install ${NAME} (ver. = ${VER}) ****"
  if [ "${VER}" = "-" ]
  then
    ${GEM} install -f ${NAME} --no-document
  else
    ${GEM} install -f ${NAME} -v=${VER} --no-document
    # issue #128対応：特定バージョンのbundlerが必要。
    if [ "${NAME}" = "bundler" ]
    then
      BUNDLER="bundle _${VER}_"
    fi
  fi
done
