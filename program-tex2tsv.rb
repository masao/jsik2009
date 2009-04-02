#!/usr/bin/env ruby
# $Id$

c = ARGF.read
puts c.chomp.gsub(/%.*$/,"").gsub(/\n/,"").split(/\\\\\\hline/).map{|e|
   e.split(/\&|\\authorsep|\\end\{authors\}|\\begin\{authors\}/).join("\t")
}.join("\n")
