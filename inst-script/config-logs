#!/bin/bash
# ALMinium関連のログをまとめて管理する

# backup log and new log's directory setting function
backup_and_new_logdir() {
  local parent_dir=$1
  local old_log_dir=$2
  local new_log_dir=$3
  local owner=$4
  local group=$5

  pushd ${parent_dir}
  # ログディレクトリが規定の場所に実態として存在する場合に
  # log/alminium配下に移動する
  if [ -d ${old_log_dir} -a ! -L ${old_log_dir} ]; then
    if [ "`ls ${old_log_dir}`" != "" ]; then
      mkdir -p ${old_log_dir}.backup
      tar cvfz ${old_log_dir}.backup/"`date +%F-%H-%M-%S`".tar.gz ${old_log_dir}
      cp -p ${old_log_dir}/* ${ALM_LOG_DIR}/${new_log_dir}/
    fi
    rm -r ${old_log_dir}
    ln -s ${ALM_LOG_DIR}/${new_log_dir} ${parent_dir}/${old_log_dir}
  fi
  chown -R ${owner}:${group} ${ALM_LOG_DIR}/${new_log_dir}
  popd
}

# each log's configuration
mkdir -p ${ALM_LOG_DIR}
mkdir -p ${ALM_LOG_DIR}/redmine
mkdir -p ${ALM_LOG_DIR}/${APACHE_LOG_DIR}
backup_and_new_logdir "${ALM_INSTALL_DIR}" "log" "redmine" "${APACHE_USER}" "${APACHE_USER}"
backup_and_new_logdir "/var/log" "${APACHE_LOG_DIR}" "${APACHE_LOG_DIR}" "root" "root"

# jenkins log configuration
if [ "${ALM_ENABLE_JENKINS}" = "y" ]; then
  mkdir -p ${ALM_LOG_DIR}/jenkins
  backup_and_new_logdir "/var/log" "jenkins" "jenkins" "jenkins" "jenkins"
fi

# db log configuration
if [ "${ALM_DB_SETUP}" = "y" -a "${ALM_USE_EXISTING_DB}" != "y" ]; then
  mkdir -p ${ALM_LOG_DIR}/${MYSQL_LOG_DIR}
  backup_and_new_logdir "/var/log" "${MYSQL_LOG_DIR}" "${MYSQL_LOG_DIR}" "mysql" "adm"
  # ubuntu1604 apparmor setting
  if [ "${APPARMOR_ENABLED}" != "" ]; then
    sed -i "s|/var/log/mysql/|/var/log/alminium/mysql/|" /etc/apparmor.d/usr.sbin.mysqld
  fi
fi
