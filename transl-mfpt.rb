#!/usr/bin/env ruby

require 'rubygems'
require 'ya2yaml'   # this gem is needed for this to work!
require 'yaml'
require 'json'
require 'uri'

def translate(sf,st)

  #ajustar arrays
  if sf.kind_of?(Array)
    slf=sf.join(" ")  
    if st then
      slt=st.join(" ") 
    end
  else
    slf=sf
    slt=st
  end

  # So obtem traducao se ainda nao existir 
  if slt then
    r=slt.strip
  else
    cmd = <<-EOF
      wget -q -O - "#{@g}#{URI.escape(slf)}"
    EOF
    cmd.strip!
    rcm=`#{cmd}`
    r=JSON.parse(rcm)["data"]["translations"].first["translatedText"].strip
  end

  #devolve array caso fosse array
  if sf.kind_of?(Array)
    r.split
  else
    r
  end

end

def processa(lf,lt)
  lf.inject({}) do |h, lfp|
    kf, vf = lfp
    if lt
      kt, vt = lt.assoc(kf)
    else
      kt, vt = nil, nil
    end
    if vf.kind_of?(Hash) then 
      h[kf] = processa(vf,vt) 
    elsif vf.kind_of?(String) then
      h[kf] = translate(vf,vt)
    elsif vf.kind_of?(Array) then 
      h[kf] = translate(vf,vt)
    else 
      h[kf] = vf
    end
    h
  end
end

f="en"
t="pt"
d1="/home/hernani/Documents/as3w/spree_i18n/config/locales"
d2="/home/hernani/Documents/as3w/spree_store_credits/config/locales"
d3="/home/hernani/Documents/as3w/spree_social/config/locales"
d4="/home/hernani/Documents/as3w/better_spree_paypal_express/config/locales"
d5="/home/hernani/Documents/as3w/spree_simple_weight_calculator/config/locales"
# Verificacao manual
dl="/home/hernani/Documents/as3w/rails-i18n/rails/locale"

# Translate API key Fruga Portugal
k="key=AIzaSyA_9z70YJc-f1bgJtJtPh4GNQyxONXoR4M"
s="source=#{f}"
a="target=#{t}-#{t.upcase}"
@g="https://www.googleapis.com/language/translate/v2?#{k}&#{s}&#{a}&q="

# carrega en.yml pt.yml de spree_i18n
hf=YAML.load_file("#{d1}/#{f}.yml")[f]
ht=YAML.load_file("#{d1}/#{t}.yml")[t]
# obtem nova traducao somente para chaves nao existentes
rp=processa(hf,ht)
# escreve pt-spree_i18n
File.open("#{t}-spree_i18n.yml", 'w') do |out|
  out.write({t => rp}.ya2yaml)
end

# carrega en.yml pt.yml de spree_store_credits
hf=YAML.load_file("#{d2}/#{f}.yml")[f]
ht=YAML.load_file("#{d2}/#{t}.yml")[t]
# obtem nova traducao somente para chaves nao existentes
rp=processa(hf,ht)
# escreve pt-spree_store_credits
File.open("#{t}-spree_store_credits.yml", 'w') do |out|
  out.write({t => rp}.ya2yaml)
end

# carrega en.yml pt.yml de spree_social
hf=YAML.load_file("#{d3}/#{f}.yml")[f]
ht=YAML.load_file("#{d3}/#{t}.yml")[t]
# obtem nova traducao somente para chaves nao existentes
rp=processa(hf,ht)
# escreve pt-spree_social
File.open("#{t}-spree_social.yml", 'w') do |out|
  out.write({t => rp}.ya2yaml)
end

# carrega en.yml pt.yml de better_spree_paypal_express
hf=YAML.load_file("#{d4}/#{f}.yml")[f]
ht=YAML.load_file("#{d4}/#{t}.yml")[t]
# obtem nova traducao somente para chaves nao existentes
rp=processa(hf,ht)
# escreve pt-better_spree_paypal_express
File.open("#{t}-better_spree_paypal_express.yml", 'w') do |out|
  out.write({t => rp}.ya2yaml)
end

# carrega en.yml pt.yml de spree_simple_weight_calculator
hf=YAML.load_file("#{d5}/#{f}.yml")[f]
ht=YAML.load_file("#{d5}/#{t}.yml")[t]
# obtem nova traducao somente para chaves nao existentes
rp=processa(hf,ht)
# escreve pt-spree_simple_weight_calculator
File.open("#{t}-spree_simple_weight_calculator.yml", 'w') do |out|
  out.write({t => rp}.ya2yaml)
end
