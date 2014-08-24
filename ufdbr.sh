#!/bin/bash

PROGNAME=${0##*/}

a="fdbr"
k="spree"
c="spree_auth_devise"
e="spree_bootstrap_frontend"
g="spree_i18n"
j="spree_social"
d="/home/hernani/Documents/as3w"
n="$d/fenix"
o="$d/init-config"

usage()
{
cat << EOF
Mantem files para loja casa dos quadros
EOF

cat <<EOF | column -s\& -t

  -h & show this output
  -s & show   files in   `basename $o`
  -n & new    files to   `basename $o`
  -u & update files in   `basename $o`
  -g & get    files from `basename $o`
  -d & diff   files in   `basename $o`
EOF
}

newsf()
{
cd $n/$1
for f in `git status|grep modified:|sed -e 's%[\t ]*modified:[\t ]*%%'`
do bn=`basename $f`
   if [ "`dirname $f|wc -c`" -gt 2 ]
   then dn="`dirname $f`/"
   else dn=""
   fi
   if [ ! -s "$o/$1/$dn$bn" ]
   then if [ ! -d "$o/$1/$dn" ];then echo "mkdir -p $o/$1/$dn";fi
        echo cp $n/$1/$dn$bn $o/$1/$dn$bn
   fi
done
for f in `git status|grep "new  *file:"|sed -e 's%[\t ]*new  *file:[\t ]*%%'`
do bn=`basename $f`
   if [ "`dirname $f|wc -c`" -gt 2 ]
   then dn="`dirname $f`/"
   else dn=""
   fi
   if [ ! -s "$o/$1/$dn$bn" ]
   then if [ ! -d "$o/$1/$dn" ];then echo "mkdir -p $o/$1/$dn";fi
        echo cp $n/$1/$dn$bn $o/$1/$dn$bn
   fi
done
}

difsf()
{
cd $o/$1
for f in `find . -type f -print`
do bn=`basename $f`
   if [ "`dirname $f|wc -c`" -gt 2 ]
   then dn="`dirname $f|cut -c3-`/"
   else dn=""
   fi
   if [ -n "`diff $dn$bn $n/$1/$dn$bn`" ]
   then echo "diff `basename $o` $1 $bn"
        diff $dn$bn $n/$1/$dn$bn
   fi
done
}

shwsf()
{
cd $o/$1
for f in `find . -type f -print`
do bn=`basename $f`
   if [ "`dirname $f|wc -c`" -gt 2 ]
   then dn="`dirname $f|cut -c3-`/"
   else dn=""
   fi
   if [ -d "$n/$1/$dn" ]
   then echo ja $1 $dn$bn
   else echo no $1 $dn$bn
   fi
done
}

updsf()
{
cd $o/$1
for f in `find . -type f -print`
do bn=`basename $f`
   if [ "`dirname $f|wc -c`" -gt 2 ]
   then dn="`dirname $f|cut -c3-`/"
   else dn=""
   fi
   if [ -n "`diff $n/$1/$dn$bn $dn$bn`" ]
   then echo cp $n/$1/$dn$bn $o/$1/$dn$bn
   #else echo no $dn$bn
   fi
done
}

getsf()
{
cd $o/$1
for f in `find . -type f -print`
do bn=`basename $f`
   if [ "`dirname $f|wc -c`" -gt 2 ]
   then dn="`dirname $f|cut -c3-`/"
   else dn=""
   fi
   if [ ! -d "$n/$1/$dn" ];then echo "mkdir -p $n/$1/$dn";fi
   echo cp $o/$1/$dn$bn $n/$1/$dn$bn
done
}

if [ ! -d $o/$a ];then mkdir $o/$a;fi
if [ ! -d $o/$k ];then mkdir $o/$k;fi
if [ ! -d $o/$c ];then mkdir $o/$c;fi
if [ ! -d $o/$e ];then mkdir $o/$e;fi
if [ ! -d $o/$g ];then mkdir $o/$g;fi
if [ ! -d $o/$j ];then mkdir $o/$j;fi

ARGS=$(getopt -a -o hnsugd --name $PROGNAME -- "$@")

eval set -- "$ARGS"

while true; do
    case $1 in
    -h)  usage ;   exit 0;;
    -n)  newsf $a;newsf $k;newsf $c;newsf $e;newsf $g;newsf $j; exit 0;;
    -s)  shwsf $a;shwsf $k;shwsf $c;shwsf $e;shwsf $g;shwsf $j; exit 0;;
    -u)  updsf $a;updsf $k;updsf $c;updsf $e;updsf $g;updsf $j; exit 0;;
    -g)  getsf $a;getsf $k;getsf $c;getsf $e;getsf $g;getsf $j; exit 0;;
    -d)  difsf $a;difsf $k;difsf $c;difsf $e;difsf $g;difsf $j; exit 0;;
    --)  shift; break;;
    *)   shift; break;;
    esac
    shift
done

usage
