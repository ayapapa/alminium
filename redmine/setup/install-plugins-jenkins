#!/bin/bash
# Jenkinsプラグインをインストールする
#

# DBセットアップをしない場合は、一時ディレクトリにダウンロードする
if [ "${ALM_DB_SETUP}" = "y" ]; then
  PLUGINS_DIR=${ALM_INSTALL_DIR}/plugins
else
  PLUGINS_DIR=${ALM_INSTALL_DIR}/plugins-jenkins
  mkdir -p ${PLUGINS_DIR}
fi
# カレントディレクトリを退避
pushd ${PLUGINS_DIR}

# install redmine_bootstrap
#git clone -b 0.2.5 https://github.com/jbox-web/redmine_bootstrap_kit.git
git clone -b redmine4 https://github.com/ayapapa/redmine_bootstrap_kit.git

# install redmine_jenkins
#git clone -b v1.x https://github.com/ayapapa/redmine_jenkins.git
git clone -b redmine4 https://github.com/ayapapa/redmine_jenkins.git

if [ "${ALM_DB_SETUP}" = "y" ]; then
  # avoid gems' version mismatch
  rm $ALM_INSTALL_DIR/Gemfile.lock

  # install gems and migrate database
  cd ..
  ${BUNDLER} install --path vendor/bundle \
                 --without development test postgresql sqlite xapian
  ${BUNDLER} exec rake redmine:plugins:migrate \
       RAILS_ENV=production NAME=redmine_jenkins
fi

# 権限を変更
chown -R ${APACHE_USER}:${APACHE_USER} ${ALM_INSTALL_DIR}/*

# ディレクトリを元に戻す
popd

