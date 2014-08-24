#!/usr/bin/env ruby

require 'ya2yaml'   # this gem is needed for this to work!
require 'yaml'
require 'json'
require 'uri'
require 'yaml2csv'

def translate(sen,spt)

  #ajustar arrays
  if sen.kind_of?(Array)
    saen=sen.join(" ")  
  else
    saen=sen
  end
  if spt then
    if spt.kind_of?(Array)
       sapt=spt.join(" ") 
    else
       sapt=spt
    end
  end

  # So obtem traducao se ainda nao existir 
  if sapt then
    # Por vezes en e una string 
    # mas pt ja foi manualmente traduzido
    # com Hash (uma estrutura mais complexa
    if spt.kind_of?(String)
      resposta=sapt.strip
    else
      resposta=sapt
    end
  else
    if saen and saen.length > 0 then
      cmd = <<-EOF
        wget -q -O - "#{@g}#{URI.escape(saen)}"
      EOF
      cmd.strip!
      rcm=`#{cmd}`
      resposta=JSON.parse(rcm)["data"]["translations"].first["translatedText"].strip
      puts "#{resposta}"
    else
      resposta=nil
    end
  end

  #devolve array caso fosse array
  if sen.kind_of?(Array)
    resposta.split
  else
    resposta
  end

end

#             en, pt
def processa(len,lpt)
  len.inject({}) do |ini, lenp|
    ken, ven = lenp
    if lpt
      kpt, vpt = lpt.assoc(ken)
    else
      kpt, vpt = ken, nil
    end
    if ven.kind_of?(Hash) then 
      ini[ken] = processa(ven,vpt) 
    elsif ven.kind_of?(String) then
      ini[ken] = translate(ven,vpt)
    elsif ven.kind_of?(Array) then 
      ini[ken] = translate(ven,vpt)
    else 
      ini[ken] = ven
    end
    if lpt
      # Em pt soma old + new keys
      lpt.merge!(ini)
      ini.merge!(lpt)
    else
      ini
    end
  end
end

a="fdbr"
d="/home/hernani/Documents/as3w"

f="en"
t="pt-BR"
d1="#{d}/fenix/spree/core/config/locales"
d2="#{d}/fenix/spree/api/config/locales"
d3="#{d}/fenix/spree/backend/config/locales"
d4="#{d}/fenix/spree_social/config/locales"
d5="#{d}/fenix/spree_auth_devise/config/locales"
df="#{d}/init-config/#{a}/config/locales"

# Translate API key Fruga Portugal
k="key=AIzaSyA_9z70YJc-f1bgJtJtPh4GNQyxONXoR4M"
s="source=#{f}"
p="target=#{t}"
@g="https://www.googleapis.com/language/translate/v2?#{k}&#{s}&#{p}&q="


# carrega en.yml pt-BR.yml global em init-config
h1=YAML.load_file("#{d1}/#{f}.yml")[f]
ht=YAML.load_file("#{df}/#{t}.yml")[t]
r1=processa(h1,ht)
h2=YAML.load_file("#{d2}/#{f}.yml")[f]
r2=processa(h2,r1)
h3=YAML.load_file("#{d3}/#{f}.yml")[f]
r3=processa(h3,r2)
h4=YAML.load_file("#{d4}/#{f}.yml")[f]
r4=processa(h4,r3)
h5=YAML.load_file("#{d5}/#{f}.yml")[f]
r5=processa(h5,r4)

File.open("#{t}.yml", 'w') do |out|
  out.write({t => r5}.ya2yaml)
end
#File.open("#{a}-#{t}.csv", 'w') do |out|
#  out.write(Yaml2csv::yaml2csv({t => r5}.ya2yaml))
#end
# Criar yml after spreadsheet edition
#File.open("#{d}/#{a}-#{t}-f.yml", 'w') do |out|
#  out.write(Yaml2csv::csv2yaml(File.open("#{a}-#{t}.csv", 'r')))
#end

