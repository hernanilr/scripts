#!/bin/bash

PROGNAME=${0##*/}

a="fdbr"
d="/home/hernani/Documents/as3w"
n="$d/fenix"
o="$d/init-config"
v="fenixdecorare"
p="hernanilr9"
h="https://api.github.com"
i="git@github.com"

usage()
{
  cat << EO
Actualiza static files para comunidade fruga
EO

  cat <<EO | column -s\& -t

  -h & show this output
  -n & new    static files to   $o
  -s & show   static files in   $o
  -u & update static files in   $o
  -g & get    static files from $o
  -d & diff   static files in   $o
EO
}

newsf()
{
cd $n/$a
for f in `git status|grep modified:|sed -e 's%[\t ]*modified:[\t ]*%%'`
do bn=`basename $f`
   if [ "`dirname $f|wc -c`" -gt 2 ]
   then dn="`dirname $f`/"
   else dn=""
   fi
   if [ ! -s "$o/$a/$dn$bn" ]
   then if [ ! -d "$o/$a/$dn" ];then echo "mkdir -p $o/$a/$dn";fi
       echo cp $dn$bn $o/$a/$dn$bn
   fi
done
}

diffsf()
{
cd $o/$a
for f in `find . -type f -print`
do bn=`basename $f`
   if [ "`dirname $f|wc -c`" -gt 2 ]
   then dn="`dirname $f|cut -c3-`/"
   else dn=""
   fi
   if [ -n "`diff $dn$bn $n/$a/$dn$bn`" ]
   then diff $dn$bn $n/$a/$dn$bn
   fi
done
}

showsf()
{
cd $o/$a
for f in `find . -type f -print`
do bn=`basename $f`
   if [ "`dirname $f|wc -c`" -gt 2 ]
   then dn="`dirname $f|cut -c3-`/"
   else dn=""
   fi
   if [ -d "$n/$a/$dn" ]
   then echo ja $dn$bn
   else echo no $dn$bn
   fi
done
}

updatesf()
{
cd $o/$a
for f in `find . -type f -print`
do bn=`basename $f`
   if [ "`dirname $f|wc -c`" -gt 2 ]
   then dn="`dirname $f|cut -c3-`/"
   else dn=""
   fi
   if [ -n "`diff $n/$a/$dn$bn $dn$bn`" ]
   then echo cp $n/$a/$dn$bn $o/$a/$dn$bn
   else echo no $dn$bn
   fi
done
}

getsf()
{
cd $o/$a
for f in `find . -type f -print`
do bn=`basename $f`
   if [ "`dirname $f|wc -c`" -gt 2 ]
   then dn="`dirname $f|cut -c3-`/"
   else dn=""
   fi
   if [ ! -d "$n/$a/$dn" ];then echo "mkdir -p $n/$a/$dn";fi
   echo cp $o/$a/$dn$bn $n/$a/$dn$bn
done
}

if [ ! -d $o/$a ];then mkdir $o/$a;fi

ARGS=$(getopt -a -o hnsugd --name $PROGNAME -- "$@")

eval set -- "$ARGS"

while true; do
    case $1 in
    -h)  usage ;   exit 0;;
    -n)  newsf;    exit 0;;
    -s)  showsf;   exit 0;;
    -u)  updatesf; exit 0;;
    -g)  getsf;    exit 0;;
    -d)  diffsf;   exit 0;;
    --)  shift; break;;
    *)   shift; break;;
    esac
    shift
done

usage
