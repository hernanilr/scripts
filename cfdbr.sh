#!/bin/bash

P=${0##*/}

a="fdbr"
d="/home/hernani/Documents/as3w/fenix"
o="/home/hernani/Documents/as3w/init-config"
v="fenixdecorare"
p="hernanilr9"
h="https://api.github.com"
i="git@github-fdbr"
export USE_LOCAL_SPREE=1

# root fenixdecorare
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

g=".";f="Gemfile"
t="1,/^ *$"
sed -n "$t/p" $g/$f                                                   > $o/$a-$f
echo -e "ruby '2.0.0'\n"                                             >> $o/$a-$f
sed    "$t/d" $g/$f|sed "s%jquery-rails' *$%jquery-rails', '3.1.0'%" >> $o/$a-$f
cat $o/$a-$f-fim                                                     >> $o/$a-$f
cp $o/$a-$f $g/$f

g="config";f="database.yml"
cp $o/$a-$f $g/$f

#[WARNING] You are not setting Devise.secret_key within your application!
#You must set this in config/initializers/devise.rb. Here's an example:
g="config/initializers";f="devise.rb"
echo 'Devise.secret_key="8c9fec4e2fd92943bce04e877c26648fd06a6fe5e876379f23bbda925cd70a7870fdda8159366cec117680fe07cb165596c4"'>$g/$f

bundle install
bundle update;bundle install
rake db:drop;rake db:create

# Instalar spree
#I18n.enforce_available_locales will default to true in the future.
#If you really want to skip validation of your locale you can set
#I18n.enforce_available_locales = false to avoid this message.
rails g spree:install --migrate=false --sample=false --seed=false --user_class=Spree::User --enforce_available_locales=true

rake spree_auth:install:migrations
rails g spree_i18n:install           # Runs migrations by default
rails g spree_social:install         # Usa input Y/n

g="config/initializers";f="spree.rb"
cp $o/$a-$f $g/$f

g="config";f="application.rb"
s="s%# *config.time_zone *= *'.*' *$%config.time_zone = 'Brasilia'%"
t="1,/config.i18n.default_locale"
sed -n "$t/p" $g/$f|sed "$s"                                  > $o/$a-$f
echo -e "    config.i18n.default_locale = 'pt-BR'"           >> $o/$a-$f
echo -e "    config.i18n.available_locales = ['pt-BR', :en]" >> $o/$a-$f
echo -e "    config.i18n.locale = 'pt-BR'"                   >> $o/$a-$f
sed    "$t/d" $g/$f                                          >> $o/$a-$f
cp $o/$a-$f $g/$f

#cp ../$a_seeds.rb db/seeds.rb

# deve ser executado depois de 
# github merge 
# porque podem haver novas migracoes
rake railties:install:migrations 
rake db:migrate
#rake spree_auth:admin:create 
rake db:seed
rake assets:precompile

../../../fenix-brand/actsite.sh -l

git init
git add .
git commit -m 'fenix init commit'
git remote add origin $i:$v/$a.git

g="fdbr";b="{ \"name\": \"$a\",\"description\": \"Loja Casa dos Quadros\" }"
curl -u "$v:$p" -X DELETE -i $h/repos/$v/$g         > $o/$a-github-$g;sleep 20
curl -u "$v:$p" -X POST   -i $h/user/repos -d "$b" >> $o/$a-github-$g;sleep 20

git push -u origin master # -u create track


heroku apps:destroy --confirm $a
heroku apps:create $a --region eu
git push heroku master

# aws amazon
# smtp configs
# sessoes usando social facebook, twiter, google+
# PAYPAY 
heroku labs:enable user-env-compile
heroku config:add AWS_ACCESS_KEY="$AWS_ACCESS_KEY"
heroku config:add AWS_SECRET="$AWS_SECRET"
heroku config:add AWS_HOST="$AWS_HOST"
heroku config:add AWS_PROTOCOL="$AWS_PROTOCOL"
heroku config:add SMTP_FRUGA="$SMTP_FRUGA"
heroku config:add SMTP_FRUGA_PASSWORD="$SMTP_FRUGA_PASSWORD"
heroku config:add FB_API_KEY="$FB_API_KEY"
heroku config:add TW_API_KEY="$TW_API_KEY"
heroku config:add GP_API_KEY="$GP_API_KEY"
heroku config:add FB_API_SECRET="$FB_API_SECRET"
heroku config:add TW_API_SECRET="$TW_API_SECRET"
heroku config:add GP_API_SECRET="$GP_API_SECRET"
heroku config:add PAYPAL_LOGIN="$PAYPAL_LOGIN"
heroku config:add PAYPAL_PASSWORD="$PAYPAL_PASSWORD"
heroku config:add PAYPAL_SIGNATURE="$PAYPAL_SIGNATURE"
heroku config:add PAYPAL_SANDBOX_LOGIN="$PAYPAL_SANDBOX_LOGIN"
heroku config:add PAYPAL_SANDBOX_PASSWORD="$PAYPAL_SANDBOX_PASSWORD"
heroku config:add PAYPAL_SANDBOX_SIGNATURE="$PAYPAL_SANDBOX_SIGNATURE"
heroku config:add PAYPAL_CLI_LOGIN="$PAYPAL_CLI_LOGIN"
heroku config:add PAYPAL_CLI_PASSWORD="$PAYPAL_CLI_PASSWORD"


heroku run rake db:migrate
heroku run rake db:seed
heroku run rake assets:precompile

heroku ps:scale web=1
heroku restart
