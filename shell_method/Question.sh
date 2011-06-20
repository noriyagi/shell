#File : Question.sh
#
#Question question default helpmessage
#
#
Question(){
if [ $# -lt 3 ]; then
	echo "Usage: Question question" \
	     "default helpmessage" 1>&2
	exit 1
fi

ANSWER=            #ユーザの入力データを代入する
_DEFAULT=$2　　　　#デフォルト時
_QUESTION=         #入力要求メッセージ
_HELPMSG=$3        #ヘルプメッセージ

if [ "$_DEFAULT" = "" ] ; then
	_QUESTION="$1? "
else
	_QUESTION="$1 [$_DEFAULT]?
fi

while :
do
	if [ "`echo -n`" = "-n" ] ; then
		echo "$_QUESTION\c"
	else
		echo -n "$_QUESTION"
	fi

	read ANSWER
	CASE `echo "$ANSWER" | tr [A-Z] [a-z]` in
		"" ) if [ "$_DEFAULT" != "" ] ; then
			ANSWER=$_DEFAULT
			break
		     fi
		     ;;
	yes | y ) ANSWER=yes
		  break
		  ;;
	 no | n ) ANSWER=no
		  break
		  ;;
       quit | q ) exit 1
		  ;;
	 +x | -x ) set $ANSWER
		  ;;
	      !* ) eval `expr "$ANSWER" : "!\(.*\)"`
	          ;;
	     "?" ) echo ""
		   if [ "$_HELPMSG" = "" ]; then
			echo "No help available."
		   else
			echo "$_HELPMSG"
		   fi
		   echo ""
		   ;;
	       * ) break
		   ;;
	ESAC
done
}

		 
