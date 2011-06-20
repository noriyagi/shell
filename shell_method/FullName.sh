#
# FullName.sh
#
FullName(){

 _CWD=`pwd`
if[ $# -ne 1 ];then
  echo "Usage: FullName filename | directory" 1>&2
  exit 1
fi

if[ -d $1 ]; then
  cd $1
  echo `pwd`
elif[ -f $1 ]; then
  cd `dirname $1`
  echo `pwd`/`basename $1`
else
  echo $1
fi

cd $_CWD
}
  
