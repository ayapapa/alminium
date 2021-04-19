#!/bin/bash
#
#

# ALMiniumインストールディレクトリへ移動
pushd ${ALM_INSTALL_DIR}

# 初回設定（アップグレードでない）ときは、DB初期設定を行う
if [ "${ALM_UPGRADE}" != "y" ]; then

  echo "*** run initialize DB ***"

  # データベースにテーブルを作成
  ${BUNDLER} exec rake db:migrate RAILS_ENV=production

  # データベースにデフォルトデータを登録
  echo 'ja' |\
  ${BUNDLER} exec rake redmine:load_default_data RAILS_ENV=production

  # プラグインをデータベースに登録
  ${BUNDLER} exec rake redmine:plugins:migrate RAILS_ENV=production

  # for XLS export
  if [ -d plugins/redmine_xls_export ]; then
    ${BUNDLER} exec rake redmine:plugins:process_version_change RAILS_ENV=production
  fi

  # for backlogs
  if [ -d plugins/redmine_backlogs ]; then
    if [ "$(db_setupped)" = "" ]; then
      ${BUNDLER} exec rake redmine:backlogs:install task_tracker=サポート \
		story_trackers=機能 labels=false RAILS_ENV=production
    else
      ${BUNDLER} exec rake redmine:backlogs:install task_tracker=タスク \
		story_trackers=機能 labels=false RAILS_ENV=production
    fi
  fi

  # キャッシュクリア
  ${BUNDLER} exec rake tmp:cache:clear RAILS_ENV=production
  #${BUNDLER} exec rake tmp:sessions:clear RAILS_ENV=production
  ${BUNDLER} exec rake tmp:clear RAILS_ENV=production

  # DB Customize
  if [ "$(db_setupped)" = "" ]; then
    echo "*** run initialize SQL ***"
    mysql `db_option` alminium < ${ALM_SRC_DIR}/redmine/setup/init.mysql
  fi
fi  # 初回設定時処理終了 

# config settings
# protocol
protocol() {
  if [ "${ALM_ENABLE_SSL}" = "y" ]; then
    echo "https"
  else
    echo "http"
  fi
}

db_update_setting 'host_name' ${ALM_HOSTNAME}${ALM_SUBDIR}
db_update_setting 'protocol' `protocol`

# ディレクトリを元に戻す
popd

