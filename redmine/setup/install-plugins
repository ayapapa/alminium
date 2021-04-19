#!/bin/bash
#
# プラグインをインストールすると同時にRedmineの初期設定を行う
#

# インストールするディレクトリ名
DEST_NAME=(`grep -v "^#" redmine/setup/redmine-plugins.lst | awk -F, '{print $1}'`)

# 展開したアーカイブのディレクトリ名 or タグ名
DIR_NAME=(`grep -v "^#" redmine/setup/redmine-plugins.lst | awk -F, '{print $2}'`)

# URL
URL_NAME=(`grep -v "^#" redmine/setup/redmine-plugins.lst | awk -F, '{print $3}'`)

for (( i = 0; i < ${#DIR_NAME[@]}; ++i ))
do
  FILE_NAME=`echo ${URL_NAME[$i]} | sed -e "s/.*\/\(.*$\)/\1/"`
  EXT=`echo ${URL_NAME[$i]} | sed -e "s/.*\.\(.*$\)/\1/"`
  echo ext=${EXT} in ${URL_NAME[$i]}
    case ${EXT} in
    zip)
        if [ ! -f cache/${FILE_NAME} ]; then
          if [[ "${OS}" == "rhel6" ]]; then
            wget -P cache ${URL_NAME[$i]} --no-check-certificate
          else
            wget -P cache ${URL_NAME[$i]}
          fi
        fi
        yes | unzip -q cache/${FILE_NAME}
         rm -fr ${ALM_INSTALL_DIR}/plugins/${DEST_NAME[$i]}
        mv ${DIR_NAME[$i]} ${ALM_INSTALL_DIR}/plugins/${DEST_NAME[$i]}
        rm -f ${FILE_NAME}
        ;;

    tgz|gz)
        if [ ! -f cache/${FILE_NAME} ]; then
          wget -P cache ${URL_NAME[$i]}
        fi
        tar zxf cache/${FILE_NAME}
        rm -fr  ${ALM_INSTALL_DIR}/plugins/${DEST_NAME[$i]}
        mv ${DIR_NAME[$i]} ${ALM_INSTALL_DIR}/plugins/${DEST_NAME[$i]}
        rm -f ${FILE_NAME}
        ;;
    git)
        if [ ! -d cache/${DEST_NAME[$i]} ]; then
          git clone ${URL_NAME[$i]} cache/${DEST_NAME[$i]}
        fi
        if [ -d cache/${DEST_NAME[$i]} ]; then
          cd cache/${DEST_NAME[$i]}
          git checkout ${DIR_NAME[$i]}
          cd ../..
          rm -fr  ${ALM_INSTALL_DIR}/plugins/${DEST_NAME[$i]}
          cp -fra cache/${DEST_NAME[$i]} ${ALM_INSTALL_DIR}/plugins/
        fi
        ;;
    *)
        if [ ! -d cache/${DEST_NAME[$i]} ]; then
          if [[ ${URL_NAME[$i]} =~ "bitbucket.org" ]]; then
            hg clone ${URL_NAME[$i]} cache/${DEST_NAME[$i]}
            cd cache/${DEST_NAME[$i]}
            hg checkout ${DIR_NAME[$i]}
            cd ../..
          else
            svn co ${URL_NAME[$i]} cache/${DEST_NAME[$i]}
            if [ "${DIR_NAME[$i]}" != "HEAD" ]; then
              cd cache/${DEST_NAME[$i]}
              svn update -r ${DIR_NAME[$i]}
              cd ../..
            fi
          fi
        fi
        rm -fr  ${ALM_INSTALL_DIR}/plugins/${DEST_NAME[$i]}
        cp -fra cache/${DEST_NAME[$i]} ${ALM_INSTALL_DIR}/plugins/${DEST_NAME[$i]}
        ;;
    esac
done

# ALMiniumインストールディレクトリへ移動
pushd ${ALM_INSTALL_DIR}

# 本パッチは、redmineダウンロードスクリプトにて実施するようにした(2021/4/19)
## fix http://www.redmine.org/issues/26637
#sed -i.org 's/filter.remote/filter[:remote]/' app/models/query.rb

# fix gem(rubyzip, nokogiri) version mismatch
# NOTE: use nokogiri 1.6.x because of jenkins_api_alient v1.3.0 
#       which is used by redmine_jenkins, and use rubyzip latest
# DMSF
sed -i.org -e "s/gem 'rubyzip',/#gem 'rubyzip',/" \
           -e "s/gem 'nokogiri'/#gem 'nokogiri'/" \
    plugins/redmine_dmsf/Gemfile
sed -i.org "s/label_dmsf_workflow_plural/label_dmsf_workflow_plural,\n      :html => {:class => 'icon dmsf_approvalworkflows'}/" \
    plugins/redmine_dmsf/init.rb
## oauth_provider
#sed -i.org "s/oauth_client_applications/oauth_client_applications, :html => {:class => 'icon oauth_clients'}/" \
#    plugins/redmine_oauth_provider/init.rb
# redmine_xls_export
sed -i.org -e 's/gem "nokogiri/#gem "nokogiri/' \
    plugins/redmine_xls_export/Gemfile
# redmine_backlogs
sed -i.org -e 's/gem "nokogiri"/gem "nokogiri", "~> 1.6.0" #/' \
           -e 's/gem "prawn"/gem "prawn", "~>2.0.0"/' \
    plugins/redmine_backlogs/Gemfile
# redmine
sed -i.org -e 's/gem "nokogiri"/gem "nokogiri", "~> 1.6.0" #/' \
           -e "s/gem 'tzinfo-data',/gem 'tzinfo-data' #,/" \
    Gemfile
# code_review
sed -i.org 's/textile.js/markdown.js/' plugins/redmine_code_review/app/views/code_review/_html_header.html.erb
# banner
sed -i.org "s/:redmine_banner, /'icon redmine_banner', /" \
    plugins/redmine_banner/init.rb

# for OAuth2認証
cd ./plugins
case ${ALM_OAUTH2_METHOD} in
google)
  git clone -b master https://github.com/twinslash/redmine_omniauth_google.git
  ;;
github)
  git clone -b v0.0.3 https://github.com/ares/redmine_omniauth_github.git
  ;;
gitlab)
  git clone -b 0.0.1 https://github.com/ayapapa/redmine_omniauth_gitlab.git
  ;;
azure)
  git clone -b master https://github.com/sohelzerdoumi/redmine_omniauth_azure.git
  ;;
esac
cd ..

# ディレクトリを元に戻す
popd

