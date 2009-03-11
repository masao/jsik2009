#!/usr/bin/env ruby
# $Id$

# Usage:
#  ./mailer.rb data.txt < inbox

require "erb"
require "kconv"

SENDMAIL = '/usr/sbin/sendmail'
FROM = 'TAKAKU.Masao@nims.go.jp'

ARGF.each do |line|
   data = line.chomp.tojis.split(/\t/)
   next if data.empty?
   message = ERB::new( STDIN.read ).result( binding )
   #puts message
   puts data[7]
   open("|#{SENDMAIL} -oi -t -f #{FROM}", "w") do |io|
      io.puts message
   end
end
