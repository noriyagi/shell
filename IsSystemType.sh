IsSystemType(){

if [ $# -ne 1 ] ; then
	echo "Usage: IsSystemType string" 1>&2
	exit 1
fi

if [ "$1" = "`uname -s`"] ; then
	return 0
elif [ "$1" = "`uname -m`"] ; then
	return 0
else
	case `uname -r` in
		"$1"*) return 0 ;;
	esac
fi
return 1
}

