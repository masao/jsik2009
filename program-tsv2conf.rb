#!/usr/bin/env ruby
# $Id$

require "erb"
require "fileutils"

$KCODE = "euc"

ARGF.each do |line|
   pid, title, author = line.chomp.split(/\t/)
   title.strip!
   author = author.gsub(/^\"(.*)\"$/, '\1').strip
   #p [ pid, title, author ]
   dirname = File.join( "form/submit", pid.gsub(/-/, "") )
   FileUtils.rm_rf( dirname + ".bak" )
   FileUtils.mv( dirname, dirname + ".bak" )
   STDERR.puts dirname
   FileUtils.cp_r( "skel", dirname )
   erb = open("form/mformcgi.conf.erb"){|io| io.read }
   open( File.join( dirname, "mformcgi.conf" ), "w" ) do |io|
      io.puts ERB.new( erb ).result( binding )
   end
end
