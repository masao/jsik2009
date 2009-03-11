#!/usr/bin/env ruby
# $Id$

require "erb"
require "kconv"

SENDMAIL = '/usr/sbin/sendmail'
FROM = 'TAKAKU.Masao@nims.go.jp'

ARGF.each do |line|
   data = line.chomp.tojis.split(/\t/)
   next if data.size <= 1
   message = ERB::new( STDIN.read ).result( binding )
   #puts message
   open("|#{SENDMAIL} -oi -t -f #{FROM}", "w") do |io|
      io.puts message
   end
end
