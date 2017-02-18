#!/bin/sh

CHKRUBY=`rpm -qa|grep ^ruby-2.1`

RET=-1

if [ "${CHKRUBY}" = "" ]
then
  pushd .

  rpmdev-setuptree

  cd ~/rpmbuild/SPECS
  # wget's bug, certificate Server Common Name
  curl -k -L -O https://raw.github.com/hansode/ruby-2.1.x-rpm/master/ruby21x.spec
  RET=$?
  if [ "${RET}" -ne "0" ]
  then
    echo "download error. 'ruby21x.spec'"
    exit 1
  fi

  RUBYVER=`grep "%define rubyver" ruby21x.spec | awk '{print $3}'`

  cd ~/rpmbuild/SOURCES
  wget http://ftp.ruby-lang.org/pub/ruby/ruby-${RUBYVER}.tar.gz

  cd ~/rpmbuild/SPECS
  rpmbuild -bb ruby21x.spec
  ARCH=`uname -m`
  rpm -Uvh ~/rpmbuild/RPMS/${ARCH}/ruby-2.1.*.rpm

  popd
fi

