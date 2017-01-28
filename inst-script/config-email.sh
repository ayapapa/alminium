#!/bin/bash

if [ "${SMTPSET}" == "" ]
then
echo "*******************************************************"
echo "  メール設定"
echo "*******************************************************"
echo "Redmineのシステムメールを送信するための設定を行います。"
echo ""
echo "＜利用する上での注意＞"
echo "・利用したいメールシステムと通信可能なことをご確認ください。ファイアーウォールなどで遮断されている場合は管理者にお問い合わせください。"
echo "・Sendmailコマンドを利用する場合、別途Sendmailの設定を行う必要があります。"
echo "・G-Mail/Hotmailを利用する場合、ユーザー名とパスワードがあれば利用可能です。"
echo ""
echo "次の中から、使いたいメールシステムを選択してください。"
echo "ここでメール設定を行わない場合は「N」を選択してください。"
echo ""
echo "0. 独自のメールサーバーを設定する"
echo "1. Linux内のSendmailコマンドを使用する"
echo "2. G-Mail/Google Apps"
echo "3. Windows Live Hotmail"
echo ""
echo "N. メール設定をしない"
echo ""
echo -n "番号選択: "
read SMTPSET
echo ""
echo ""
fi

case "${SMTPSET}" in
	"0" ) 
	echo "*******************************************************"
	echo "  メールサーバー設定"
	echo "*******************************************************"

	if [ "${SMTPSERVER}" == "" ]
	then
		echo "SMTPサーバー名を入力してください"
		echo ""
		echo -n "SMTPサーバー: "
		read SMTPSERVER
		echo ""
		echo ""
	fi

	if [ "${SMTPTLS}" == "" ]
	then
		echo ""
		echo "暗号化が必要なメールサーバーですか？"
		echo "SSL/TLS暗号化が必要な場合は「Y」、不要な場合は「n」を入力してください。"
		echo ""
		echo -n "暗号化が必要ですか？[Y/n]: "
		read SMTPTLS
		echo ""
		echo ""
	fi
	
	if [ "${SMTPPORT}" == "" ]
	then
		echo ""
		echo "メール送信に使用するポート番号を入力してください。"
		echo "・通常は「25」で設定します。"
		echo "・暗号化を行なっているサーバーや、迷惑メール対策(Port25 Blocking)のサブミッションポートを使う場合などは違うポートになります。"
		echo ""
		echo -n "ポート番号: "
		read SMTPPORT
		echo ""
		echo ""
	fi	
	
	if [ "${SMTPLOGIN}" == "" ]
	then
		echo ""
		echo "メール送信時、サーバーで認証(ログイン)する必要はありますか？"
		echo "認証が必要な場合は「Y」、不要な場合は「n」を入力してください。"
		echo ""
		echo -n "ログインが必要ですか？[Y/n]: "
		read SMTPLOGIN
		echo ""
		echo ""
	fi	

	if [ "${SMTPLOGIN}" == "Y" ]
	then	

		if [ "${SMTPUser}" == "" ]
		then
			echo ""
			echo "SMTPユーザー名を入力してください。"
			echo ""
			echo -n "ユーザー名: "
			read SMTPUser
			echo ""
			echo ""
		fi

		if [ "${SMTPPass}" == "" ]
		then
			echo ""
			echo "SMTPパスワードを入力してください。"
			echo ""
			echo -n "パスワード: "
			read SMTPPass
			echo ""
			echo ""
		fi		
	fi	
	;;

	"1" ) echo "「Linux内のSendmailコマンドを使用する」を選択しました。"
	;;

	"2" )
	echo "*******************************************************"
	echo "  G-Mail/Google Apps設定"
	echo "*******************************************************"
	
	if [ "${SMTPUser}" == "" ]
	then
		echo "G-Mailのユーザー名を入力してください。"
		echo ""
		echo -n "ユーザー名: "
		read SMTPUser
		echo ""
		echo ""
	fi
	
	if [ "${SMTPPass}" == "" ]
	then
		echo ""
		echo "G-Mailのパスワードを入力してください。"
		echo ""
		echo -n "パスワード: "
		read SMTPPass
		echo ""
		echo ""
	fi

	SMTPSERVER=smtp.gmail.com
	SMTPTLS=Y
	SMTPPORT=587
	SMTPLOGIN=Y
	;;
	
	"3" )
	echo "*******************************************************"
	echo "  Windows Live Hotmail設定"
	echo "*******************************************************"
	
	if [ "${SMTPUser}" == "" ]
	then
		echo "HotmailのMicrosoftアカウントを入力してください。"
		echo ""
		echo -n "Microsoftアカウント: "
		read SMTPUser
		echo ""
		echo ""
	fi
	
	if [ "${SMTPPass}" == "" ]
	then
		echo ""
		echo "Hotmailのパスワードを入力してください。"
		echo ""
		echo -n "パスワード: "
		read SMTPPass
		echo ""
		echo ""
	fi

	SMTPSERVER=smtp.live.com
	SMTPTLS=n
	SMTPPORT=587
	SMTPLOGIN=Y
	;;
	
	* )
	echo "メール設定を行いません。"
	echo ""
	echo ""
	;;
esac
