#File: DownShift.sh
#
DownShift(){
    echo "$@" | tr '[A-Z]' '[a-z]'
}
