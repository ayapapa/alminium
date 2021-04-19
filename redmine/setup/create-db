#!/bin/bash
#
#

# create db
if [ "${ALM_UPGRADE}" != "y" ]; then
  echo "*** create ALMinium DB ***"
  if [ "$(db_test alminium)" = "" ]; then
    if [ "$(db_test)" != "" ]; then
      # create alminium DB
      DB_OPTION_ROOT="`db_option_root`"
      mysql $(db_option_root) < ${ALM_SRC_DIR}/redmine/setup/createdb.sql
    else
      echo "データベースを作成することが出来ません。データベースへのアクセス
権の設定を確認してください。"
      exit 1
    fi
  fi
fi
