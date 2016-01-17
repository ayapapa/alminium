#!/bin/bash

case "$SMTPSET" in
	"1" )
	echo "default:
  email_delivery:
    delivery_method: :sendmail" > $ALM_INSTALL_DIR/config/configuration.yml
	;;
	
	"0" | "2" | "3" )
	echo "default:
  email_delivery:
    delivery_method: :smtp
    smtp_settings:
      address: $SMTPSERVER
      port: $SMTPPORT
      domain: $ALM_HOSTNAME" > $ALM_INSTALL_DIR/config/configuration.yml

	if [ "$SMTPTLS" == "Y" ]
	then
	echo "      enable_starttls_auto: true" >> $ALM_INSTALL_DIR/config/configuration.yml
	fi

	if [ "$SMTPLOGIN" == "Y" ]
	then
	echo "      authentication: :login
      user_name: $SMTPUser
      password: $SMTPPass" >> $ALM_INSTALL_DIR/config/configuration.yml
	fi
	;;
	
	* ) ;;
esac

