#!/bin/bash

P=${0##*/}

a="mfpt"
d="/home/hernani/Documents/as3w"
o="$d/init-config"
v="hernanilr"
p="pprglh99"
h="https://api.github.com"
i="git@github.com"
export USE_LOCAL_SPREE=1

rvm --force gemset delete $a
rvm gemset create $a

# CLONE LOCAL GEMS
g="spree";u="spree";b="2-1-stable"
cd $d;rm -rf $g
curl -u "$v:$p" -X DELETE -i $h/repos/$v/$g        > $o/$a-github-$g
curl -u "$v:$p" -X POST   -i $h/repos/$u/$g/forks >> $o/$a-github-$g
git clone $i:$v/$g.git
if [ -d $d/$g ]
then cd "$d/$g"
     git remote add github $i:$u/$g.git
     git fetch github
     git checkout -t -b $b github/$b
     echo "2.0.0" > .ruby-version;echo "$a" > .ruby-gemset
else echo "Erro git clone $i:$v/$g.git"
fi

g="spree_auth_devise";u="radar";b="2-1-stable"
cd $d;rm -rf $g
curl -u "$v:$p" -X DELETE -i $h/repos/$v/$g        > $o/$a-github-$g
curl -u "$v:$p" -X POST   -i $h/repos/$u/$g/forks >> $o/$a-github-$g
git clone $i:$v/$g.git
if [ -d $d/$g ]
then cd "$d/$g"
     git remote add github $i:$u/$g.git
     git fetch github
     git checkout -t -b $b github/$b
     echo "2.0.0" > .ruby-version;echo "$a" > .ruby-gemset
else echo "Erro git clone $i:$v/$g.git"
fi

g="spree_i18n";u="spree";b="2-1-stable"
cd $d;rm -rf $g
curl -u "$v:$p" -X DELETE -i $h/repos/$v/$g        > $o/$a-github-$g
curl -u "$v:$p" -X POST   -i $h/repos/$u/$g/forks >> $o/$a-github-$g
git clone $i:$v/$g.git
if [ -d $d/$g ]
then cd "$d/$g"
     git remote add github $i:$u/$g.git
     git fetch github
     git checkout -t -b $b github/$b
     echo "2.0.0" > .ruby-version;echo "$a" > .ruby-gemset
else echo "Erro git clone $i:$v/$g.git"
fi

g="spree_store_credits";u="spree";b="2-1-stable"
cd $d;rm -rf $g
curl -u "$v:$p" -X DELETE -i $h/repos/$v/$g        > $o/$a-github-$g
curl -u "$v:$p" -X POST   -i $h/repos/$u/$g/forks >> $o/$a-github-$g
git clone $i:$v/$g.git
if [ -d $d/$g ]
then cd "$d/$g"
     git remote add github $i:$u/$g.git
     git fetch github
     git checkout -t -b $b github/$b
     echo "2.0.0" > .ruby-version;echo "$a" > .ruby-gemset
else echo "Erro git clone $i:$v/$g.git"
fi

g="spree_social";u="spree";b="2-1-stable"
cd $d;rm -rf $g
curl -u "$v:$p" -X DELETE -i $h/repos/$v/$g        > $o/$a-github-$g
curl -u "$v:$p" -X POST   -i $h/repos/$u/$g/forks >> $o/$a-github-$g
git clone $i:$v/$g.git
if [ -d $d/$g ]
then cd "$d/$g"
     git remote add github $i:$u/$g.git
     git fetch github
     git checkout -t -b $b github/$b
     echo "2.0.0" > .ruby-version;echo "$a" > .ruby-gemset
else echo "Erro git clone $i:$v/$g.git"
fi

g="better_spree_paypal_express";u="radar";b="2-1-stable"
cd $d;rm -rf $g
curl -u "$v:$p" -X DELETE -i $h/repos/$v/$g        > $o/$a-github-$g
curl -u "$v:$p" -X POST   -i $h/repos/$u/$g/forks >> $o/$a-github-$g
git clone $i:$v/$g.git
if [ -d $d/$g ]
then cd "$d/$g"
     git remote add github $i:$u/$g.git
     git fetch github
     git checkout -t -b $b github/$b
     echo "2.0.0" > .ruby-version;echo "$a" > .ruby-gemset
else echo "Erro git clone $i:$v/$g.git"
fi

g="spree_simple_weight_calculator";u="freego";b="2-0-stable"
cd $d;rm -rf $g
curl -u "$v:$p" -X DELETE -i $h/repos/$v/$g        > $o/$a-github-$g
curl -u "$v:$p" -X POST   -i $h/repos/$u/$g/forks >> $o/$a-github-$g
git clone $i:$v/$g.git
if [ -d $d/$g ]
then cd "$d/$g"
     git remote add github $i:$u/$g.git
     git fetch github
     git checkout -t -b $b github/$b
     echo "2.0.0" > .ruby-version;echo "$a" > .ruby-gemset
     z="$d/$g"
     f="spree_simple_weight_calculator.gemspec"
     s="s%spree_core', *'~> 2.0.0'%spree_core', '~> 2.0'%"
     sed "$s" $z/$f > $o/$a-$f
     cp $o/$a-$f $z/$f
     git commit -am "fruga problema de compatibilidade"
     git push origin
else echo "Erro git clone $i:$v/$g.git"
fi

exit

cd $d
rm -rf $a
rails _4.0.0_ new $a -d postgresql
cd "$d/$a"
echo "2.0.0" > .ruby-version;echo "$a" > .ruby-gemset

g=".";f="Gemfile"
t="1,/^ *$"
sed -n "$t/p" $g/$f       > $o/$a-$f
echo -e "ruby '2.0.0'\n" >> $o/$a-$f
sed    "$t/d" $g/$f      >> $o/$a-$f
cat $o/$a-$f-fim         >> $o/$a-$f

cp $o/$a-$f $g/$f
g="config";f="database.yml"
cp $o/$a-$f $g/$f

bundle install
bundle update;bundle install
rake db:drop;rake db:create

# Instalar spree
rails g spree:install --migrate=false --sample=false --seed=false
rake spree_auth:install:migrations
rails g spree_i18n:install           # Runs migrations by default
rails g spree_store_credits:install  # Usa input Y/n
rails g spree_social:install         # Usa input Y/n
rails g spree_paypal_express:install # Usa input Y/n

cp ../$a_spree.rb config/initializers/spree.rb
cp ../$a_application.rb config/application.rb
cp ../$a_seeds.rb db/seeds.rb

# deve ser executado depois de 
# github merge 
# porque podem haver novas migracoes
rake railties:install:migrations 
rake db:migrate
#rake spree_auth:admin:create 
rake db:seed
#rake spree_sample:load
rake assets:precompile

git init
git commit -am 'fruga commit 1'
git remote add origin git@github.com:hernanilr/$a.git
git push -u origin master # -u create track

../../fruga-brand/actsite.sh -m

git init
git add .
git commit -m "fruga primeiro commit"

# Primeiro criar repositorio github 
git remote add origin git@github.com:hernanilr/$a.git
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
