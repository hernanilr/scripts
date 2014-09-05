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

# este script so pode ser corrido com copy pastes
exit 

# CLONE LOCAL GEMS
g="antwort";u="InterNations";b="master"
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

g="asset_sync";u="rumblelabs";b="master"
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
     # spree tem fenix ufdbr
     $j/scripts/ufdbr.sh -m|sh
     git add .
     git commit -m 'fenix ufdbr'
     git push origin
else echo "Erro git clone $i:$v/$g.git"
fi

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
     # spree tem fenix ufdbr
     $j/scripts/ufdbr.sh -k|sh
     git add .
     git commit -m 'fenix ufdbr'
     git push origin
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

bundle install
bundle update;bundle install
rake db:drop;rake db:create

git init
git add .
git commit -m 'fenix init commit'

# Instalar spree
# Usa input admin user
spring stop
rails g spree:install --migrate=false --sample=false --seed=false --user_class=Spree::User --enforce_available_locales=true

rake spree_auth:install:migrations
rails g spree_i18n:install           # Runs migrations by default

# Usam inputs
# spree_social estraga spree_bootstrap/frontend all.css
# por isso ufdbr.sh repoe uma versao all.css boa
rails g spree_bootstrap_frontend:install
rails g spree_social:install         

# Inicializacao da configuracao fenix
$j/scripts/ufdbr.sh -l|sh

# heroku sem DB da erro em asset:precompile
# Retirado mais abaixo
rake assets:precompile
git add .
git commit -m 'fenix assets:precompile init heroku DB'

g="fdbr";b="{ \"name\": \"$a\",\"description\": \"Loja Casa dos Quadros\" }"
curl -u "$v:$p" -X DELETE -i $h/repos/$v/$g         > $o/$a-github-$g;sleep 20
curl -u "$v:$p" -X POST   -i $h/user/repos -d "$b" >> $o/$a-github-$g;sleep 20

git remote add origin $i:$v/$a.git
git push -u origin master

#INIT heroku
heroku apps:destroy --confirm $a
heroku apps:create $a

# numero de processos unicorn 
# 1 dyno consegue 4 max - limitacoes de memoria
heroku config:set WEB_CONCURRENCY="4"

# aws amazon
heroku config:set FDAWS_BUCKET="$FDAWS_BUCKET"
heroku config:set FDAWS_KEY="$FDAWS_KEY"
heroku config:set FDAWS_SECRET="$FDAWS_SECRET"

# gem asset_sync uses these with these names
heroku config:set FOG_PROVIDER="$FOG_PROVIDER"
heroku config:set FOG_DIRECTORY="$FOG_DIRECTORY"
heroku config:set FOG_REGION="$FOG_REGION"

# spree_login_social
heroku config:set FDGP_API_KEY="$FDGP_API_KEY"
heroku config:set FDGP_API_SECRET="$FDGP_API_SECRET"
heroku config:set FDTW_API_KEY="$FDTW_API_KEY"
heroku config:set FDTW_API_SECRET="$FDTW_API_SECRET"

# action mailer
heroku config:set FDSMTP="$FDSMTP"
heroku config:set FDSMTP_PASSWORD="$FDSMTP_PASSWORD"

git push heroku master

heroku addons:add pgbackups:auto-month

# newrelic addon ja cria uma app e LICENSE KEY por defeito
heroku addons:add newrelic:wayne
heroku config:set NEW_RELIC_APP_NAME="$FDNEW_RELIC_APP_NAME"
heroku config:set NEW_RELIC_LICENSE_KEY="$FDNEW_RELIC_LICENSE_KEY"
# parauactivar/desacivar agente
heroku config:set NEWRELIC_AGENT_ENABLED=false

# Para colocar assets:precompile no heroku precisa ter DB
heroku run rake db:migrate
heroku run rake db:seed
rm -rf public/assets
git add . -A
git commit -m 'fenix assets:precompile feito no heroku'
git push origin master
git push heroku master

# deve ser executado depois de github merge 
# porque podem haver novas migracoes
rake railties:install:migrations 
rake db:migrate
rake db:seed

# Fenix brand & images & static files
$k/fenix-brand/actsite.sh
$k/fenix-images/actsite.sh
$j/scripts/ufdbr.sh -a|sh

echo "RACK_ENV=development" >> .env
echo "PORT=3000" >> .env
echo ".env" >> .gitignore

spring stop
bandle update;bundle install

git add .
git commit -m 'fenix ufdbr'
git push origin master
git push heroku master

heroku run rake railties:install:migrations
heroku run rake db:migrate
heroku run rake db:seed

heroku domains:add loja.casadosquadros.com.br
heroku domains:add loja.casadosquadros.com
heroku ps:scale web=1
heroku restart

#heroku run rake assets:sync 
