#!/bin/bash

a="cfpt"
d="/home/hernani/Documents/as3w"
o="$d/init-config"
v="frugapt"
p="pprglh99"
h="https://api.github.com"
i="git@github.com"
g="publify"
u="publify"
b="master"

# CLONE LOCAL COPY 
cd "$d"
rm -rf $a
curl -u "$v:$p" -X DELETE -i $h/repos/$v/$a                            > $o/$a-github-$g;sleep 20
curl -u "$v:$p" -X POST   -i $h/repos/$u/$g/forks                     >> $o/$a-github-$g;sleep 20
curl -u "$v:$p" -X PATCH  -i $h/repos/$v/$g -d "{ \"name\": \"$a\" }" >> $o/$a-github-$g;sleep 20
git clone $i:$v/$a.git
if [ -d $d/$a ]
then cd "$d/$a"
     git remote add github $i:$u/$g.git
     git fetch github
     git checkout -t -b $b github/$b
     cp $o/$a/.project .project
     echo "2.0.0" > .ruby-version
     echo "$a" > .ruby-gemset
else echo "Erro git clone $i:$v/$a.git"
     exit 1
fi
cd "$d"
cd "$d/$a"
rvm --force gemset delete $a
rvm gemset create $a

s="/^ *group  *:assets *do *$/,/^ *end *$"
t="1,/^end *$/d;$s/d"
z="s%^ *%%"
cp            $o/$a-Gemfile-ini                                $o/$a-Gemfile
sed -n "$s/p" $d/$a/Gemfile|tail -n +2|head -n -1|sed "$z"  >> $o/$a-Gemfile
sed "$t"      $d/$a/Gemfile|grep -v thin                    >> $o/$a-Gemfile
mv $o/$a-Gemfile $d/$a/Gemfile

z="$d/$a/config/initializers"
t="1,/^ *:provider *="
s="s%\"aws_bucket\"%'CFAWS_BUCKET'%;s%\"aws_access_key_id\"%'CFAWS_ACCESS_KEY'%;s%\"aws_secret_access_key\"%'CFAWS_SECRET'%"
sed -n "$t/p" $z/carrierwave.rb                                   > $o/$a-carrierwave.rb
echo "        :region                 => ENV['CFAWS_REGION'],"   >> $o/$a-carrierwave.rb
echo "        :host                   => ENV['CFAWS_HOST'],"     >> $o/$a-carrierwave.rb
echo "        :endpoint               => ENV['CFAWS_ENDPOINT']," >> $o/$a-carrierwave.rb
sed    "$t/d" $z/carrierwave.rb|sed "$s"                         >> $o/$a-carrierwave.rb
mv $o/$a-carrierwave.rb $z/carrierwave.rb 

z="$d/$a/config"
s="s%server_s%smtp_s%;s%mail_settings = YAML.load(F%mail_settings = YAML.load(ERB.new(F%;s%l\.yml\"))%l.yml\")).result)%"
sed "$s" $z/application.rb > $o/$a-application.rb
mv $o/$a-application.rb $z/application.rb

z="$d/$a/app/services/admin"
s="s%return *true *unless *File.exists? *file%return true unless File.exists? @file%"
sed "$s" $z/token_checker.rb > $o/$a-token_checker.rb
mv $o/$a-token_checker.rb $z/token_checker.rb

z="$d/$a/app/models"
s=""
s="$s;s%find_all_with_article_counters *$%find_all_with_article_counters(limit=1000,skip=0)%"
s="$s;s% *, *true *, *1000 *, *0 *%,true, limit, skip%"
s="$s;s%self.display_name *= *self.name%self.display_name = self.name.capitalize%"
s="$s;s%self.name *= *self.display_name.to_url%if self.name.blank?\n      self.name = self.display_name.to_url\n    end%"
sed "$s" $z/tag.rb > $o/$a-tag.rb
mv $o/$a-tag.rb $z/tag.rb

z="$d/$a/app/mailers"
s="s%New article:%Novo artigo:%"
s="s%New comment on%Novo comentário sobre%;$s"
s="s%Welcome to Publify%Bem vindo à Comunidade Fruga%;$s"
s="s%Publify #{PUBLIFY_VERSION}%Comunidade Fruga #{PUBLIFY_VERSION}%;$s"
sed "$s" $z/notification_mailer.rb > $o/$a-notification_mailer.rb
mv $o/$a-notification_mailer.rb $z/notification_mailer.rb 

z="$d/$a/app/helpers"
t="1,/^ *<<-HTML *$/p"
v="1,/^ *HTML *$/d;s%   new_js_distance_of_time_in_words_to_now%   distance_of_time_in_words_to_now%"
sed -n "$t" $z/application_helper.rb      > $o/$a-application_helper.rb
cat $o/$a-universal-analytics-tracking >> $o/$a-application_helper.rb
sed    "$v" $z/application_helper.rb     >> $o/$a-application_helper.rb
mv $o/$a-application_helper.rb $z/application_helper.rb

z="$d/$a/config/environments"
t="1,/^ *config"
sed -n "$t/p" $z/production.rb                        > $o/$a-production.rb
echo "  config.active_support.deprecation = :notify" >> $o/$a-production.rb
sed    "$t/d" $z/production.rb                       >> $o/$a-production.rb
mv $o/$a-production.rb $z/production.rb 

z="$d/$a/lib"
s="s%:pt_BR%:pt_BR, :pt_PT%"
if [ -n "`grep -il :pt_PT $z/publify_lang.rb`" ]
then cp $z/publify_lang.rb         $o/$a-publify_lang.rb
else sed "$s" $z/publify_lang.rb > $o/$a-publify_lang.rb
fi
mv $o/$a-publify_lang.rb $z/publify_lang.rb

# Heroku needs these out
t="/Gemfile.lock/d;/mail.yml/d;/database.yml/d;/secret.token/d"
sed "$t" $d/$a/.gitignore > $o/$a-gitignore
mv $o/$a-gitignore $d/$a/.gitignore

z="$d/$a/config/locales"
../transl-cfpt.rb
if [ -n "`diff $d/$a-pt.yml $o/$a/config/locales/pt.yml`" ]
then diff $d/$a-pt.yml $o/$a/config/locales/pt.yml
     echo "Verificar novas traducoes"
     cp $o/$a/config/locales/pt.yml $o/$a-pt.yml
fi
mv $d/$a-pt.yml $o/$a/config/locales/pt.yml
cp $o/$a/config/locales/pt.yml $z/pt.yml

#Actualiza fruga-brand images 
#O logo precisa de um dir proprio
mkdir "$d/$a/app/assets/images/logo"
../../fruga-brand/actsite.sh -c

# Para usar gem bootstrap-sass
# Remover bootstrap do publify
for f in `find . -name "*bootstrap*" -type f -print`
do bn=`basename $f`
   if [ "`dirname $f|wc -c`" -gt 2 ]
   then dn="`dirname $f|cut -c3-`/"
   else dn=""
   fi
   cp $dn$bn $o/$a-deleted-`echo $dn|sed -e 's%/%-%g'`$bn
   rm $dn$bn
   git rm $dn$bn
done
# Actualiza fruga.css.scss
s="$d/$a/app/assets/stylesheets"
grep -v "bootstrap" $s/publify.css.scss          > $o/$a-cfpt.scss
grep -v "bootstrap" $s/publify_admin.css.scss    > $o/$a-cfpt_admin.scss
../../fruga-brand/preppng.sh -q                  > $o/$a-fruga-brand.scss
cat $o/$a-cfpt.scss       $o/$a-fruga-brand.scss > $s/cfpt.css.scss
cat $o/$a-cfpt_admin.scss $o/$a-fruga-brand.scss > $s/cfpt_admin.css.scss
# Actualiza js
s="$d/$a/app/assets/javascripts"
t="1,/require_self"
grep -v "bootstrap" $s/publify.js     > $o/$a-cfpt.js
sed -n "$t/p" $o/$a-cfpt.js|head -n-1 > $s/cfpt.js
echo "//= require bootstrap"         >> $s/cfpt.js
echo "//= require_self"              >> $s/cfpt.js
sed    "$t/d" $o/$a-cfpt.js          >> $s/cfpt.js
cat $s/publify_admin.js               > $s/cfpt_admin.js

git commit -m "c$a.sh init deleted files"

git add .
git commit -m "c$a.sh init auto produced files"

# ficheiros estaticos no init-config
../ucfpt.sh -g

git diff > $o/$a-gitdiff

git add .
git commit -m "c$a.sh init static files"

# Para garantir gemset correcto
cd "$d"
cd "$d/$a"
rvm gemset use $a
# precisa de um primeiro install senao o update da erro
bundle install
bundle update;bundle install
rake db:drop
rake db:create
rake db:migrate
rake db:seed

# Para gerar fruga-brand paginate views
rails g kaminari:views default
../ucfpt.sh -g

git add .
git commit -m "c$a.sh init kaminari paginate fruga views"

git push origin

heroku apps:destroy --confirm $a
heroku apps:create $a --region eu
heroku addons:add pgbackups:auto-month
heroku addons:add newrelic:wayne
heroku config:set CFSMTP="$CFSMTP"
heroku config:set CFSMTP_PASSWORD="$CFSMTP_PASSWORD"
heroku config:set NEW_RELIC_APP_NAME="$CFNEW_RELIC_APP_NAME"
heroku config:set NEW_RELIC_LICENSE_KEY="$CFNEW_RELIC_LICENSE_KEY"
heroku config:set CFAWS_ACCESS_KEY="$CFAWS_ACCESS_KEY"
heroku config:set CFAWS_SECRET="$CFAWS_SECRET"
heroku config:set CFAWS_REGION="$CFAWS_REGION"
heroku config:set CFAWS_HOST="$CFAWS_HOST"
heroku config:set CFAWS_ENDPOINT="$CFAWS_ENDPOINT"
heroku config:set CFAWS_BUCKET="$CFAWS_BUCKET"
heroku config:set provider="$provider"

git push heroku master

heroku run rake db:migrate;sleep 500
heroku run rake db:seed   ;sleep 500
heroku ps:scale web=1
heroku domains:add comunidade.fruga.pt
heroku domains:add www.fruga.pt
heroku restart

#heroku open
#heroku addons:upgrade pgbackups:auto-week
