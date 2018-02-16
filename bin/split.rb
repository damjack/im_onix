#!/usr/bin/env ruby
require 'nokogiri'
require 'onixo'

filename = ARGV[0]
cnt = ARGV[1] || 500
cnt = cnt.to_i

puts "#{filename}"

class OnixoSplitter
  def initialize(filename, output_name)
    @filename = filename
    @output_name = output_name
  end

  def write_part(file_count, part)
    out_filename = @output_name + "." + file_count.to_s + ".xml"
    puts "Write file #{out_filename}"
    fw = File.open(out_filename, 'w')
    fw.write("<ONIXMessage release=\"3.0\" xmlns=\"http://ns.editeur.org/onix/3.0/reference\">\n")
    part.each do |p|
      fw.write p
    end
    fw.write("</ONIXMessage>\n")
    fw.close
  end

  def count
    current_part_count = 0
    Onixo::Helpers::Converter.each_xml_product(@filename) do |product_str|
      current_part_count += 1
    end
    current_part_count
  end

  def split(max_parts)
    file_count = 0
    current_part = []
    current_part_count = 0
    Onixo::Helpers::Converter.each_xml_product(@filename) do |product_str|
      tmp_parser = Onixo::Parser.new()
      output = tmp_parser.analyze(product_str)

      current_part[current_part_count] ||= ""
      current_part[current_part_count] += product_str + "\n"

      if output[:products].first.sold_separately?
        current_part_count += 1
      end

      if current_part_count > max_parts - 1
        write_part(file_count, current_part)
        current_part = []
        current_part_count = 0
        file_count += 1
      end
    end

    if current_part_count > 0
      write_part(file_count, current_part)
      current_part = []
      current_part_count = 0
    end

    true
  end
end

splitter = OnixoSplitter.new(filename, "out/splitted")
splitter.split(cnt)
puts splitter.count
