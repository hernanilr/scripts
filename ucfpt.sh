#!/bin/bash

PROGNAME=${0##*/}

a="cfpt"
d="/home/hernani/Documents/as3w"
o="$d/init-config"
v="frugapt"
p="pprglh99"
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
cd $d/$a
for f in `git status|grep modified:|sed -e 's%[\t ]*modified:[\t ]*%%'`
do bn=`basename $f`
   if [ "`dirname $f|wc -c`" -gt 2 ]
   then dn="`dirname $f`/"
   else dn=""
   fi
   if [ ! -s "$o/$a/$dn$bn" ]
   then echo "cp $dn$bn $o/$a/$dn$bn"
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
   if [ -n "`diff $dn$bn $d/$a/$dn$bn`" ]
   then diff $dn$bn $d/$a/$dn$bn
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
   if [ -d "$d/$a/$dn" ]
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
   if [ -n "`diff $d/$a/$dn$bn $dn$bn`" ]
   then echo cp $d/$a/$dn$bn $o/$a/$dn$bn
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
   if [ -d "$d/$a/$dn" ]
   then cp $o/$a/$dn$bn $d/$a/$dn$bn
        #echo cp $dn$bn
   else echo no $dn$bn
   fi
done
}

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
