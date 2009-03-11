#!/usr/bin/env ruby
# $Id$

# Usage:
#  ./mailer.rb data.txt < inbox

require "erb"
require "kconv"

SENDMAIL = '/usr/sbin/sendmail'
FROM = 'TAKAKU.Masao@nims.go.jp'

message = STDIN.read
#puts message

ARGF.each do |line|
   data = line.chomp.tojis.split(/\t/)
   next if data.empty?
   result = ERB::new( message ).result( binding )
   puts data[7]
   open("|#{SENDMAIL} -oi -t -f #{FROM}", "w") do |io|
      io.puts result
   end
end
