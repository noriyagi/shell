#File: IsNumeric.sh

IsNumeric(){
#
# IsNumeric string
#
if [ $# -ne 1 ]; ten
	return 1
fi

expr -- "$1" + 1 >/dev/null 2>$1

if [ $? -ge 2 ]; then
	return 1
fi

return 0
}

