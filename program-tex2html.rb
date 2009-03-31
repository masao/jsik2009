#!/usr/bin/env ruby
# $Id$

lines = ARGF.readlines
table = ""
within_tabular = false
lines[ lines.find_index{|e| /^\\subsection/ =~ e } .. -1 ].each do |line|
   line.sub!(/%.*$/, "")
   line.gsub!(/\\([\w\*]+)(\{.*?\})?(\{.*?\})?(\{.*?\})?/) do |match|
      command = $1
      arg1 = $2
      arg2 = $3
      arg3 = $4
      #p [ command, arg1, within_tabular ]
      if command == "begin" and arg1 =~ /^\{tabular\}/
         within_tabular = true
      elsif command == "end" and arg1 =~ /^\{tabular\}/
         within_tabular = false
      end
#       if within_tabular and command == "multicolumn"
#          #arg3.sub( /\{(.*)\}/ ){ $1 }
#          match
#       elsif within_tabular and /\\(begin|end)\{authors\}/ =~ match
#          match
      if within_tabular
         match
      else
         ""
      end
   end
   if within_tabular
      table << line
   else
      line.sub!(/\\\\$/, "")
      line.gsub!(/\\\\/, "\n")
   end
end

puts "<table>"
table.split(/\\\\/).each do |tr|
   puts "<tr>"
   tr.split(/\&/).each do |td|
      attr = {}
      style = []
      td.sub!( /\\begin\{tabular\}.*$/, '' )
      td.sub!( /\\begin\{authors\}/, '<div class="authors">' )
      td.sub!(/\\end\{authors\}/, '</div>' )
      td.sub!( /\\multicolumn\{([0-9]+)\}\{([\|\w]+)\}\{(.*?)\}/ ) do |match|
         attr[:colspan] = $1 if $1.to_i > 1
         style << "center" if $2.include?( "c" )
         $3
      end
      td.gsub!( /\\(\w+)/ ) do |match|
         case $1
         when "bf", "sf"
            style << "strong"
         when "footnotesize", "small"
            style << "small"
         end
         ""
      end
      td.strip!
      if not style.empty?
         style.each do |e|
            td = "<#{e}>#{td}</#{e}>"
         end
      end
      attr_s = ""
      if not attr.empty?
         attr_s = " " << attr.keys.map{|k| %Q[#{k}="#{attr[k]}"] }.join(" ")
      end
      puts "<td#{attr_s}>#{td}</td>"
   end
   puts "</tr>"
end
puts "</table>"
#puts table
