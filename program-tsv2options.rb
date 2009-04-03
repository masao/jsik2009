#!/usr/bin/env ruby
# -*- coding: euc-jp -*-
# $Id$

$KCODE = "euc"

def shorten( str, len = 120 )
   matched = str.gsub( /\n/, ' ' ).scan( /^.{0,#{len - 2}}/ )[0]
   if $'.nil? || $'.empty?
      matched
   else
      matched + '...'
   end
end

ARGF.each do |line|
   pid, title, author = line.chomp.split(/\t/)
   title.strip!
   author = author.gsub(/^\"(.*)\"$/, '\1').strip
   #p [ pid, title, author ]
   authors = author.split(/, /)
   authors_str  =authors[0].split[0]
   # authors_str << "ほか" if authors.size > 1
   puts %Q[<option value="#{ pid.gsub(/-/,"") }">[#{ pid }] #{ authors_str }: #{ shorten(title,20) }</option>]
end
