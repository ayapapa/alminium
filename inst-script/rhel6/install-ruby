#!/bin/bash

# install build dependencies
yum install -y git-core zlib zlib-devel gcc-c++ patch readline readline-devel libyaml-devel libffi-devel openssl-devel make bzip2 autoconf automake libtool bison curl sqlite-devel

# ruby
# if ruby is old, remove
if [ "`which ruby`" != "" -a "`ruby -v | grep 2.1.`" != "" ]; then
  echo -n "Version 2.1のrubyがインストールされています。削除して新しいバージョンをインストールします。"
  echo -n "インストールを中止する場合は、ctrl+cでスクリプトの実行を中断してください。"
  read CONTINUE
  gem uninstall bundler
  yum -y remove ruby ruby-devel rubygem-nokogiri rubygem-rack rubygem-rake rubygem-rake-compiler
fi

# clone and install rbenv environment
if [ "`which rbenv`" = "" ]; then
  git clone git://github.com/sstephenson/rbenv.git ~/.rbenv
  git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
  echo export PATH=/root/.rbenv/shims:'$PATH' >> /etc/profile
  echo 'export PATH="${HOME}/.rbenv/bin:$PATH"' >> ~/.bash_profile
  echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
  # re-init bash
  source ~/.bash_profile
  # add permission for execution
  chmod o+x /root
  chmod o+x /root/.rbenv
fi

# install latest ruby
RBVER=2.5.1
rbenv install -s -v ${RBVER}
rbenv rehash

#sets the default ruby version that the shell will use
rbenv global ${RBVER}

# to disable generating of documents as that would take so much time
echo "gem: --no-document" > ~/.gemrc

# install bundler
gem install bundler

# must be executed everytime a gem has been installed in order for the ruby executable to run
rbenv rehash
