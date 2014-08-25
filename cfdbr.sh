#!/bin/bash

P=${0##*/}

a="fdbr"
k="/home/hernani/Documents"
j="$k/as3w"
d="$j/fenix"
o="$j/init-config"
v="fenixdecorare"
p="hernanilr9"
h="https://api.github.com"
i="git@github-fenix"
m="<?xml version=\"1.0\" encoding=\"UTF-8\"?>"
m="$m\n<projectDescription>"
n="\n\t<comment></comment>\n\t<projects>\n\t</projects>"
l="\n\t<buildSpec>\n\t\t<buildCommand>\n\t\t\t<name>com.aptana.ide.core.unifiedBuilder</name>"
l="$l\n\t\t\t<arguments>\n\t\t\t</arguments>\n\t\t</buildCommand>\n\t</buildSpec>"
l="$l\n\t<natures>\n\t\t<nature>com.aptana.ruby.core.rubynature</nature>\n\t</natures>"
l="$l\n</projectDescription>"

# root fenix
if [ -d $d ]
then cd $d
else mkdir $d;cd $d
fi

# CLONE LOCAL GEMS
g="spree";u="spree";b="2-3-stable"
cd $d;rm -rf $g
curl -u "$v:$p" -X DELETE -i $h/repos/$v/$g        > $o/$a-github-$g;sleep 20
curl -u "$v:$p" -X POST   -i $h/repos/$u/$g/forks >> $o/$a-github-$g;sleep 20
git clone $i:$v/$g.git
if [ -d $d/$g ]
then cd "$d/$g"
     git remote add github $i:$u/$g.git
     git fetch github
     git checkout -t -b $b github/$b
     echo "2.0.0" > .ruby-version;echo "$a" > .ruby-gemset
     echo -e "$m\n\t<name>$a-$g</name>$n$l" > .project
else echo "Erro git clone $i:$v/$g.git"
fi

g="spree_auth_devise";u="radar";b="2-3-stable"
cd $d;rm -rf $g
curl -u "$v:$p" -X DELETE -i $h/repos/$v/$g        > $o/$a-github-$g;sleep 20
curl -u "$v:$p" -X POST   -i $h/repos/$u/$g/forks >> $o/$a-github-$g;sleep 20
git clone $i:$v/$g.git
if [ -d $d/$g ]
then cd "$d/$g"
     git remote add github $i:$u/$g.git
     git fetch github
     git checkout -t -b $b github/$b
     echo "2.0.0" > .ruby-version;echo "$a" > .ruby-gemset
     echo -e "$m\n\t<name>$a-$g</name>$n$l" > .project
else echo "Erro git clone $i:$v/$g.git"
fi

g="spree_i18n";u="spree";b="2-3-stable"
cd $d;rm -rf $g
curl -u "$v:$p" -X DELETE -i $h/repos/$v/$g        > $o/$a-github-$g;sleep 20
curl -u "$v:$p" -X POST   -i $h/repos/$u/$g/forks >> $o/$a-github-$g;sleep 20
git clone $i:$v/$g.git
if [ -d $d/$g ]
then cd "$d/$g"
     git remote add github $i:$u/$g.git
     git fetch github
     git checkout -t -b $b github/$b
     echo "2.0.0" > .ruby-version;echo "$a" > .ruby-gemset
     echo -e "$m\n\t<name>$a-$g</name>$n$l" > .project
else echo "Erro git clone $i:$v/$g.git"
fi

g="spree_bootstrap_frontend";u="200Creative";b="2-3-stable"
cd $d;rm -rf $g
curl -u "$v:$p" -X DELETE -i $h/repos/$v/$g        > $o/$a-github-$g;sleep 20
curl -u "$v:$p" -X POST   -i $h/repos/$u/$g/forks >> $o/$a-github-$g;sleep 20
git clone $i:$v/$g.git
if [ -d $d/$g ]
then cd "$d/$g"
     git remote add github $i:$u/$g.git
     git fetch github
     git checkout -t -b $b github/$b
     echo "2.0.0" > .ruby-version;echo "$a" > .ruby-gemset
     echo -e "$m\n\t<name>$a-$g</name>$n$l" > .project
else echo "Erro git clone $i:$v/$g.git"
fi

g="spree_social";u="spree";b="2-3-stable"
cd $d;rm -rf $g
curl -u "$v:$p" -X DELETE -i $h/repos/$v/$g        > $o/$a-github-$g;sleep 20
curl -u "$v:$p" -X POST   -i $h/repos/$u/$g/forks >> $o/$a-github-$g;sleep 20
git clone $i:$v/$g.git
if [ -d $d/$g ]
then cd "$d/$g"
     git remote add github $i:$u/$g.git
     git fetch github
     git checkout -t -b $b github/$b
     echo "2.0.0" > .ruby-version;echo "$a" > .ruby-gemset
     echo -e "$m\n\t<name>$a-$g</name>$n$l" > .project
else echo "Erro git clone $i:$v/$g.git"
fi

# Create root aplication
rvm --force gemset delete $a
rvm gemset create $a
rvm gemset use $a
gem install rails -v 4.1.4
cd $d;rm -rf $a
rails _4.1.4_ new $a -d postgresql
cd $d/$a
echo "2.0.0" > .ruby-version;echo "$a" > .ruby-gemset
echo -e "$m\n\t<name>$a</name>$n$l" > .project

g=".";f="Gemfile"
s="s%jquery-rails' *$%jquery-rails', '3.1.0'%"
s="s%# *gem *'unicorn'.*$%gem 'unicorn', group: :production%;$s"
t="1,/^ *$"
sed -n "$t/p" $g/$f           > $o/$a-$f
echo -e "ruby '2.0.0'\n"     >> $o/$a-$f
sed    "$t/d" $g/$f|sed "$s" >> $o/$a-$f
cat $o/$a-$f-fim             >> $o/$a-$f
cp $o/$a-$f $g/$f

g="config";f="database.yml"
cp $o/$a-$f $g/$f

#[WARNING] You are not setting Devise.secret_key within your application!
#You must set this in config/initializers/devise.rb. Here's an example:
g="config/initializers";f="devise.rb"
echo "Devise.secret_key=\"<%= ENV['SECRET_KEY_BASE'] %>\"">$g/$f

g="config/initializers";f="assets.rb"
t="1,/Rails.application.config.assets.version"
sed -n "$t/p" $g/$f                                        > $o/$a-$f
echo -e "Rails.application.config.assets.compress = true" >> $o/$a-$f
sed    "$t/d" $g/$f                                       >> $o/$a-$f
cp $o/$a-$f $g/$f

bundle install
bundle update;bundle install
rake db:drop;rake db:create

git init
git add .
git commit -m 'fenix init commit'

# Instalar spree
# Usa input admin user
rails g spree:install --migrate=false --sample=false --seed=false --user_class=Spree::User --enforce_available_locales=true

rake spree_auth:install:migrations
rails g spree_i18n:install           # Runs migrations by default

# Usam inputs
# spree_social estraga spree_bootstrap/frontend all.css
# por isso ufdbr.sh repoe uma versao all.css boa
rails g spree_bootstrap_frontend:install
rails g spree_social:install         

g="config/environments";f="production.rb"
s="s%config.serve_static_assets *= *false%config.serve_static_assets=true%"
t="1,/dump_schema_after_migration"
sed -n "$t/p" $g/$f|sed "$s"                                                                                 > $o/$a-$f
echo -e ""                                                                                                  >> $o/$a-$f
echo -e "  # Enable serving of images, stylesheets, and JavaScripts from an asset server."                  >> $o/$a-$f
echo -e "  config.action_controller.asset_host = \"//#{ENV['FOG_DIRECTORY']}.s3-sa-east-1.amazonaws.com\""  >> $o/$a-$f
echo -e "  # store assets in a 'folder' instead of bucket root"                                             >> $o/$a-$f
echo -e "  #config.assets.prefix = '/assets'"                                                               >> $o/$a-$f
echo -e ""                                                                                                  >> $o/$a-$f
echo -e "  # configurar S3"                                                                                 >> $o/$a-$f
echo -e "  config.paperclip_defaults = {"                                                                   >> $o/$a-$f
echo -e "      storage: :s3,"                                                                               >> $o/$a-$f
echo -e "      s3_storage_class: :reduced_redundancy,"                                                      >> $o/$a-$f
echo -e "      s3_host_alias: ENV['FDAWS_BUCKET'],"                                                         >> $o/$a-$f
echo -e "      s3_host_name: 's3-sa-east-1.amazonaws.com',"                                                 >> $o/$a-$f
echo -e "      url: :s3_alias_url,"                                                                         >> $o/$a-$f
echo -e "      bucket: ENV['FDAWS_BUCKET'],"                                                                >> $o/$a-$f
echo -e "      s3_credentials: { access_key_id: ENV['FDAWS_KEY'], secret_access_key: ENV['FDAWS_SECRET'] }" >> $o/$a-$f
echo -e "  }"                                                                                               >> $o/$a-$f
echo -e ""                                                                                                  >> $o/$a-$f
sed    "$t/d" $g/$f                                                                                         >> $o/$a-$f
cp $o/$a-$f $g/$f

spring stop
bundle update;bundle install

# Vou passar a precompilar para manter versoes no github
# e para copiar glyphicons fonts sem fingerprint
rake assets:precompile 
rake assets:clean 
cp `bundle show bootstrap-sass`/assets/fonts/bootstrap/* public/assets/bootstrap/
ft="`ls public/assets/[fF]ont[aA]wesome-[a-z0-9][a-z0-9]*\.*|grep -v webfont`"
ft="$ft `ls public/assets/fontawesome-webfont-[a-z0-9][a-z0-9]*\.*`"
for f in $ft
do dn=`dirname $f`
   bn=`basename $f`
   ex=`echo $bn|cut -d'.' -f2`
   nf=`echo $bn|sed -e 's%^\([a-zA-Z][a-zA-Z\-]*\)-.*%\1%'`
   cp $f $dn/$nf.$ex
done

git add .
git commit -m 'fenix init heroku'

g="fdbr";b="{ \"name\": \"$a\",\"description\": \"Loja Casa dos Quadros\" }"
curl -u "$v:$p" -X DELETE -i $h/repos/$v/$g         > $o/$a-github-$g;sleep 20
curl -u "$v:$p" -X POST   -i $h/user/repos -d "$b" >> $o/$a-github-$g;sleep 20

git remote add origin $i:$v/$a.git
git push -u origin master

#INIT heroku
heroku apps:destroy --confirm $a
heroku apps:create $a

# aws amazon
heroku config:set FDAWS_BUCKET="$FDAWS_BUCKET"
heroku config:set FDAWS_KEY="$FDAWS_KEY"
heroku config:set FDAWS_SECRET="$FDAWS_SECRET"

# gem asset_sync uses these with these names
heroku config:set FOG_PROVIDER="$FOG_PROVIDER"
heroku config:set FOG_DIRECTORY="$FOG_DIRECTORY"
heroku config:set FOG_REGION="$FOG_REGION"

heroku config:set FDGP_API_KEY="$FDGP_API_KEY"
heroku config:set FDGP_API_SECRET="$FDGP_API_SECRET"
heroku config:set FDTW_API_KEY="$FDTW_API_KEY"
heroku config:set FDTW_API_SECRET="$FDTW_API_SECRET"
heroku config:set FDSMTP="$FDSMTP"
heroku config:set FDSMTP_PASSWORD="$FDSMTP_PASSWORD"

git push heroku master

heroku addons:add pgbackups:auto-month

# newrelic addon ja cria uma app e LICENSE KEY por defeito
heroku addons:add newrelic:wayne
heroku config:set NEW_RELIC_APP_NAME="$FDNEW_RELIC_APP_NAME"
heroku config:set NEW_RELIC_LICENSE_KEY="$FDNEW_RELIC_LICENSE_KEY"
heroku config:set WEB_CONCURRENCY="4"

heroku run rake db:migrate

g="config/initializers";f="spree.rb"
echo -e "SpreeI18n::Config.available_locales=[:'pt-BR']" >> $g/$f
echo -e "SpreeI18n::Config.supported_locales=[:'pt-BR']" >> $g/$f

g="config";f="application.rb"
s="s%# *config.time_zone *= *'.*' *$%config.time_zone = 'Brasilia'%"
s="s%enforce_available_locales *= *true%enforce_available_locales = false%;$s"
t="1,/config.i18n.default_locale"
sed -n "$t/p" $g/$f|sed "$s"                                                                     > $o/$a-$f
echo -e "    config.i18n.default_locale = :'pt-BR'"                                             >> $o/$a-$f
echo -e "    config.i18n.available_locales = [:'pt-BR']"                                        >> $o/$a-$f
echo -e "    config.i18n.locale = :'pt-BR'"                                                     >> $o/$a-$f
echo -e ""                                                                                      >> $o/$a-$f
echo -e "    config.action_mailer.default_url_options = { host: 'loja.casadosquadros.com.br' }" >> $o/$a-$f
echo -e "    config.action_mailer.delivery_method = :smtp"                                      >> $o/$a-$f
echo -e "    config.action_mailer.raise_delivery_errors = true "                                >> $o/$a-$f
echo -e "    config.action_mailer.smtp_settings = { "                                           >> $o/$a-$f
echo -e "      address: 'smtp.mandrillapp.com',"                                                >> $o/$a-$f
echo -e "      port: 587,"                                                                      >> $o/$a-$f
echo -e "      domain: 'casadosquadros.com.br',"                                                >> $o/$a-$f
echo -e "      enable_starttls_auto: true,"                                                     >> $o/$a-$f
echo -e "      authentication:  :plain,"                                                        >> $o/$a-$f
echo -e "      user_name: ENV['FDSMTP'],"                                                       >> $o/$a-$f
echo -e "      password: ENV['FDSMTP_PASSWORD']"                                                >> $o/$a-$f
echo -e "      }"                                                                               >> $o/$a-$f
echo -e ""                                                                                      >> $o/$a-$f
sed    "$t/d" $g/$f                                                                             >> $o/$a-$f
cp $o/$a-$f $g/$f

# deve ser executado depois de 
# github merge 
# porque podem haver novas migracoes
rake railties:install:migrations 
rake db:migrate
#rake spree_auth:admin:create 
rake db:seed

# Fenix brand
$k/fenix-brand/actsite.sh -l

# Repor fenix static files em init-config
$j/scripts/ufdbr.sh -g|sh

echo "RACK_ENV=development" >> .env
echo "PORT=3000" >> .env
echo ".env" >> .gitignore

spring stop
bundle update;bundle install
rake assets:precompile 
rake assets:clean 

git add .
git commit -m 'fenix brand & assets'
git push origin master
git push heroku master

heroku run rake railties:install:migrations

heroku run rake db:migrate

heroku run rake db:seed

heroku domains:add loja.casadosquadros.com.br
heroku ps:scale web=1

# depois de gem asset_sync preciso disto para sync with s3
heroku run rake assets:precompile 
heroku run rake assets:clean 

heroku restart
