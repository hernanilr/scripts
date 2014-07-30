#!/usr/bin/env ruby

require 'rubygems'
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
      kpt, vpt = nil, nil
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
      ini.merge!(lpt)
    else
      ini
    end
  end
end

a="cfpt"
d="/home/hernani/Documents/as3w"

f="en"
t="pt"
d1="#{d}/#{a}/config/locales"
df="#{d}/init-config/#{a}/config/locales"

# Translate API key Fruga Portugal
k="key=AIzaSyA_9z70YJc-f1bgJtJtPh4GNQyxONXoR4M"
s="source=#{f}"
p="target=#{t}-#{t.upcase}"
@g="https://www.googleapis.com/language/translate/v2?#{k}&#{s}&#{p}&q="

# carrega en.yml pt.yml
hf=YAML.load_file("#{d1}/#{f}.yml")[f]
ht=YAML.load_file("#{df}/#{t}.yml")[t]
# obtem nova traducao somente para chaves nao existentes

rp=processa(hf,ht)
# escreve pt
File.open("#{d}/#{a}-#{t}.yml", 'w') do |out|
  out.write({t => rp}.ya2yaml)
end

# Criar csv para spreadsheet edition
#File.open("#{d}/#{a}-#{t}.csv", 'w') do |out|
#  out.write(Yaml2csv::yaml2csv({t => rp}.ya2yaml))
#end
#File.open("#{d}/#{a}-#{f}.csv", 'w') do |out|
#  out.write(Yaml2csv::yaml2csv({f => hf}.ya2yaml))
#end
# Criar yml after spreadsheet edition
#File.open("#{d}/#{a}-#{t}-f.yml", 'w') do |out|
#  out.write(Yaml2csv::csv2yaml(File.open("#{d}/#{a}-#{t}.csv", 'r')))
#end
