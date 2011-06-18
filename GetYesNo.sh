# GetYesNo "massage"

GetYesNo(){
_ANSWER = 

if [ $# -eq 0 ]; then
     echo "Usage : GetYesNo message " 1>&2
     exit 1
fi

while :
     do 
       if [ "`echo -n`" = "-n" ]; then
         echo "$@\c"
       else
         echo -n "$@"
       fi
       read _ANSWER
       case "$_ANSWER" in
          [yY] | yes | YES | Yes ) return o ;;
          [nN] | no | NO | No ) return 1 ;;
          *) echo "Please enter y or n." ;;
       esac
done
}
