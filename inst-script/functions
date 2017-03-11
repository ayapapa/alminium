# DB操作コマンドオプション(for root)
db_option_root() {
  local db_host=${ALM_DB_HOST:-localhost}
  local root_pass=${ALM_DB_ROOT_PASS}

  if [ "${root_pass}" = "" ] ; then
    echo "-uroot -h${db_host}"
  else
    echo "-uroot -h${db_host} -p${root_pass}"
  fi
}

# DB操作コマンドオプション(for alminium)
db_option() {
  local db_host=${ALM_DB_HOST:-localhost}
  echo "-ualminium -h${db_host} -palminium"
}

# DBにALMinium設定有無チェック
db_setupped() {
  mysql `db_option` -e "SELECT name FROM settings;" \
	 alminium | grep welcome_text
}

# DBのsettingsテーブルのレコード有無チェック
db_exist_record() {
  echo "SELECT * FROM settings WHERE name = '$1';" | mysql `db_option` alminium
}

# DB内のsettingsテーブルの指定レコード$1を指定の値$2に書き換える
# レコードが存在しない場合は、新たにレコードを挿入する
db_update_setting() {
  if [ "`db_exist_record $1`" = "" ]; then
    echo "REPLACE INTO settings(name,value,updated_on) " \
         "VALUES ('$1','$2', now());" | mysql `db_option` alminium
  else
    echo "UPDATE settings SET value = '$2' WHERE name = '$1';" | mysql `db_option` alminium
  fi
}

# データベース接続テスト
# 戻り値が非nullなら接続成功
db_test() {
  if [ "${1}" = "alminium" ]; then
    OPT=`db_option`
    DB_NAME=alminium
  else
    OPT=`db_option_root`
    DB_NAME=mysql
  fi
  echo `mysql ${OPT} -e "status" ${DB_NAME} 2>/dev/null`
}

