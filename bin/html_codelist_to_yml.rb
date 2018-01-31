#!/usr/bin/ruby
require 'open-uri'
require 'nokogiri'
require 'yaml'

class HTMLCodelist
  private
  def self.parse_codelist(doc, idx)
    h = {}
    doc.css("table > tbody > tr").each do |tr|
      code = tr.at_css("td.code").text.strip
      human = tr.at_css("td.preflabel a").text.strip
      if(code != "" && human)
        h[code] = self.rename(human)
      end
    end
    File.open("data/codelists/codelist_#{idx}.yml", 'w') do |fw|
      fw.write(h.to_yaml)
    end
  end

  # from rails
  def self.rename(term)
    term.gsub(/\(|\)|\,|\-|’|\/|“|”|‘|\.|\:|–|\||\+/,"").gsub(/\;/," Or ").gsub(/\s+/," ").split(" ").map{|t| t.capitalize}.join("")
  end
end

239.times do |i|
  html = Nokogiri::HTML.parse(open("https://ns.editeur.org/onix/en/#{i+1}"))
  flash = html.at_css('.flash')
  if(flash.nil?)
    HTMLCodelist.parse_codelist(html, i+1)
  else
     puts "#{flash.text} - #{i+1}"
  end
end
