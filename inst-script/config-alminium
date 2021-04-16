#!/bin/bash
# MySQLインストールに関する注意
echo ""
echo "途中MySQLのパスワードを聞かれたら空のままエンターキーを押してください。"
echo "MySQLのパスワードを設定するとインストールに失敗します。"
echo "パスワードを設定したい場合は、ALMiniumのインストール完了後行ってください"
echo ""

# ホスト名設定
if [ "${ALM_HOSTNAME}" = "" ]; then
  echo "*******************************************************"
  echo "  ホスト名の設定"
  echo "*******************************************************"
  echo "ホスト名(IPアドレスもしくはDNS名)を入力してください。ホスト名はApacheのバーチャルホストで利用されます。"
  echo "例えば、192.168.1.4をホスト名で入力すると、http://192.168.1.4/でアクセスすることになります。"
  if [ -f ${ALM_ETC_DIR}/redmine.conf ]; then
    IP_ADDR="`grep ^ServerName ${ALM_ETC_DIR}/redmine.conf | sed 's/^ServerName //'`"
  else
    IP_ADDR="`ip -f inet -o addr show ${ETH0} | cut -d\  -f 7 | cut -d/ -f 1`"
  fi
  echo -n "ホスト名[${IP_ADDR}]:"
  read ALM_HOSTNAME
  ALM_HOSTNAME=${ALM_HOSTNAME:-${IP_ADDR}}
  echo ""
fi

# SSL設定
if [ "${ALM_ENABLE_SSL}" = "" ]; then
  echo "*******************************************************"
  echo "  SSLのサポート"
  echo "*******************************************************"
  echo "SSLのサポートを有効にすると、httpsのみの接続を許可します。"
  echo "httpでのアクセスは、全てhttpsのポートへ転送されるようになります。"
  echo "SSLの証明書は認証機関により署名されたものではありません。通信の暗号化のみ"
  echo "に利用します。"
  echo "gitの利用では、"
  echo ""
  echo "  $ git config --global http.sslVerify false"
  echo ""
  echo "などのコマンドで、SSLの証明書を無効にする必要があります。"
  echo ""
  echo -n "SSL(https)サポートを有効にしますか?(y/N) "
  read ALM_ENABLE_SSL
  echo ""
  echo ""
fi

#
# サブディレクトリ指定
#
if [ "${ALM_RELATIVE_URL_ROOT}" = "" ]; then
  echo "*****************************"
  echo "  サブディレクトリ指定  "
  echo "*****************************"
  echo "サブディレクトリを指定すると"
  echo "http[s]://(サーバー名)/(サブディレクトリ)"
  echo "でアクセスすることができます。"
  echo "指定しない場合はそのままEnterキーを押下してください"
  echo -n "サブディレクトリー名："
  read ALM_SUBDIR
  echo ""
  echo ""
else
  ALM_SUBDIR="${ALM_RELATIVE_URL_ROOT}"
fi

if [ "${ALM_SUBDIR}" != "" ]; then
  if [ `echo ${ALM_SUBDIR} | cut -c 1` != '/' ]; then
    ALM_SUBDIR="/${ALM_SUBDIR}"
  fi
fi

# source inst-script/config-email.sh

# jenkins
if [ "${ALM_UPGRADE}" != "y" -a "${ALM_ENABLE_JENKINS}" = "" ]; then
  echo -n "継続的インテグレーションツールのJenkinsのインストール・設定を"
  echo -n "行うことができます。デフォルトはインストールしません。"
  echo -n "よく分からなければNを選択してください。"
  echo -n ""
  echo -n "Jenkinsをインストールしますか?(y/N)"
  read ALM_ENABLE_JENKINS
  echo ""
fi

# OAuth2認証
if [ "${ALM_OAUTH2_METHOD}" = "" ]; then
  echo "### 本機能は実験中（動作確認が不十分）です ###"
  echo "OAuth2認証サービス(プロバイダ)を選択してください:"
  echo "  1: Google"
  echo "  2: GitHub"
  echo "  3: GitLab (オンプレミスサービスも指定可能)"
  echo "  4: Azure"
  echo "  other: OAuth2認証を利用しない"
  echo -n "利用したいサービスの番号をお選びください: "
  read ALM_OAUTH2_METHOD
  if [ "${ALM_OAUTH2_METHOD}" = "" ] ; then
    ALM_OAUTH2_METHOD="N"
  fi
fi
case ${ALM_OAUTH2_METHOD} in
1)
  ALM_OAUTH2_METHOD=google
  ;;
2)
  ALM_OAUTH2_METHOD=github
  ;;
3)
  ALM_OAUTH2_METHOD=gitlab
  ;;
4)
  ALM_OAUTH2_METHOD=azure
  ;;
*)
  ALM_OAUTH2_METHOD=N
  ;;
esac

