#!/bin/bash
#
# バックアップ設定を行うスクリプト
#
ALM_VAR_DIR=${ALM_VAR_DIR:-/var/opt/alminium}
ALM_ETC_DIR=${ALM_ETC_DIR:-/etc/opt/alminium}
ALM_BACKUP_DIR=${ALM_BACKUP_DIR:-${ALM_VAR_DIR}-backup}
ALM_BACKUP_LOG=${ALM_BACKUP_LOG:-/opt/alminium/log/backup.log}
ALM_BACKUP_MINUTE=${ALM_BACKUP_MINUTE:-0}
ALM_BACKUP_HOUR=${ALM_BACKUP_HOUR:-3}
ALM_BACKUP_DAY=${ALM_BACKUP_DAY:-*/2}
ALM_BACKUP_EXPIRY=${ALM_BACKUP_EXPIRY:-14}

cd ${ALM_SRC_DIR}
mkdir -p ${ALM_BACKUP_DIR}
if [ -f ${ALM_ETC_DIR}/alminium-backup-cron ]; then
  sed -e "s|#ALM_BACKUP_DIR#|${ALM_BACKUP_DIR}|" \
      -e "s|#ALM_BACKUP_LOG#|${ALM_BACKUP_LOG}|" \
      -e "s|#ALM_BACKUP_MINUTE#|${ALM_BACKUP_MINUTE}|" \
      -e "s|#ALM_BACKUP_HOUR#|${ALM_BACKUP_HOUR}|" \
      -e "s|#ALM_BACKUP_DAY#|${ALM_BACKUP_DAY}|" \
      -e "s|#ALM_BACKUP_EXPIRY#|${ALM_BACKUP_EXPIRY}|" \
      -e "s|#ALM_DB_HOST#|${ALM_DB_HOST}|" \
      ${ALM_ETC_DIR}/alminium-backup-cron > /etc/cron.d/alminium-backup-cron
  chown root:root /etc/cron.d/alminium-backup-cron
else
  echo -n バックアップ設定ファイルが見つかりません。
  echo    インストール中にエラーが発生した可能性があります。
fi

