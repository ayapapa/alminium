#!/bin/bash

cp inst-script/mac/scm.yml.mac $ALM_INSTALL_DIR/config/scm.yml

if [ ! -f /opt/local/apache2/Authn/Redmine.pm ]
then
  mkdir -p /opt/local/apache2/Authn
  cp etc/Redmine.pm /opt/local/apache2/Authn/
fi

if [ "$ALM_ENABLE_SSL" = "y" ]; then REPLACE_SSL="#SSL# *"; fi
if [ "$ALM_ENABLE_JENKINS" = "y" ]; then REPLACE_JENKINS="#JENKINS# *"; fi
if [ "$ALM_SUBDIR" = "y" ]; then REPLACE_DIR="#SUBDIR# *"; else REPLACE_DIR="#NO_SUBDIR# *"; fi
for FILE in $(ls etc/ | grep '.conf$')
do
  sed -e "s|#HOSTNAME#|$ALM_HOSTNAME|" \
      -e "s|#$OS# *||" \
      -e "s|$REPLACE_SSL||" \
      -e "s|$REPLACE_JENKINS||" \
      -e "s|$REPLACE_DIR||" \
      "etc/$FILE" > "$ALM_ETC_DIR/$FILE"
done

ln -sf "$ALM_ETC_DIR/passenger.conf" "$APACHE_CONF_DIR/"
ln -sf "$ALM_ETC_DIR/alminium.conf"  "$APACHE_CONF_DIR/"

pushd .

cd /opt/local/apache2/libexec
/opt/local/apache2/bin/apxs -a -e -n "perl" mod_perl.so

popd

launchctl load -w /Library/LaunchDaemons/org.macports.apache2.plist
/opt/local/apache2/bin/apachectl restart
