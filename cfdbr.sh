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
git remote add origin $i:$v/$a.git

# Instalar spree
# Usa input admin user
rails g spree:install --migrate=false --sample=false --seed=false --user_class=Spree::User --enforce_available_locales=true

rake spree_auth:install:migrations
rails g spree_i18n:install           # Runs migrations by default

# Usa input Y/n
rails g spree_social:install         

g="config";f="production.rb"
s="s%config.serve_static_assets *= *false%config.serve_static_assets=true%"
sed "$s" $g/$f > $o/$a-$f
cp $o/$a-$f $g/$f

spring stop
bundle update;bundle install
# heroku deploy da erro em assets:precompile
rake assets:precompile 
git add .
git commit -m 'fenix init heroku'

g="fdbr";b="{ \"name\": \"$a\",\"description\": \"Loja Casa dos Quadros\" }"
curl -u "$v:$p" -X DELETE -i $h/repos/$v/$g         > $o/$a-github-$g;sleep 20
curl -u "$v:$p" -X POST   -i $h/user/repos -d "$b" >> $o/$a-github-$g;sleep 20

git push -u origin master

#INIT heroku
heroku apps:destroy --confirm $a
heroku apps:create $a
#heroku addons:add pgbackups:auto-month
# aws amazon
heroku config:add AWS_ACCESS_KEY="$AWS_ACCESS_KEY"
heroku config:add AWS_SECRET="$AWS_SECRET"
heroku config:add AWS_HOST="$AWS_HOST"
heroku config:add AWS_PROTOCOL="$AWS_PROTOCOL"
git push heroku master
heroku run rake db:migrate

g="config/initializers";f="spree.rb"
echo -e "SpreeI18n::Config.available_locales=[:'pt-BR']" >> $g/$f
echo -e "SpreeI18n::Config.supported_locales=[:'pt-BR']" >> $g/$f

g="config";f="application.rb"
s="s%# *config.time_zone *= *'.*' *$%config.time_zone = 'Brasilia'%"
s="s%enforce_available_locales *= *true%enforce_available_locales = false%;$s"
t="1,/config.i18n.default_locale"
sed -n "$t/p" $g/$f|sed "$s"                              > $o/$a-$f
echo -e "    config.i18n.default_locale = :'pt-BR'"      >> $o/$a-$f
echo -e "    config.i18n.available_locales = [:'pt-BR']" >> $o/$a-$f
echo -e "    config.i18n.locale = :'pt-BR'"              >> $o/$a-$f
sed    "$t/d" $g/$f                                      >> $o/$a-$f
cp $o/$a-$f $g/$f

g="db";f="seeds.rb"
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

# Usar heroku recomendation for HTTP server unicorn
g="config";f="unicorn.rb"
cp $o/$a-$f $g/$f
g="config/initializers";f="timeout.rb"
cp $o/$a-$f $g/$f
g=".";f="Procfile"
cp $o/$a-$f $g/$f
echo "RACK_ENV=development" >> .env
echo "PORT=3000" >> .env
echo ".env" >> .gitignore

spring stop
bundle update;bundle install
#O heroku precisa disto no INIT
rm -rf public/assets/
git status|grep deleted:|sed 's%[ \t]*deleted: *%git rm %'|sh
git add .
git commit -m 'fenix brand & assets'
git push -u origin master
git push heroku master

heroku run rake db:migrate;sleep 500
heroku run rake db:seed;sleep 500
#heroku run rake assets:precompile

heroku ps:scale web=1
heroku restart
