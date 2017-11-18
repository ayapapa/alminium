#!/bin/bash

# set Redmine.pm
mkdir -p /etc/perl/Apache/Authn
rm -f /etc/perl/Apache/Authn/Redmine.pm
ln -s ${ALM_INSTALL_DIR}/extra/svn/Redmine.pm /etc/perl/Apache/Authn/Redmine.pm

# set Apache configs
ln -sf "${ALM_ETC_DIR}/alminium.conf"  "/etc/apache2/sites-available/alminium.conf"

a2enmod expires
a2enmod dav_fs
a2enmod authz_svn
a2enmod proxy_http
a2enmod headers
a2enmod rewrite
a2enmod passenger
a2enmod perl
a2enmod wsgi
a2enmod cgi
a2dismod mpm_event
a2enmod mpm_prefork
a2ensite alminium

# vim: set ts=2 sw=2 et:
