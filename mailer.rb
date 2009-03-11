#!/usr/bin/env ruby
# $Id$

# Usage:
#  ./mailer.rb data.txt < inbox

require "erb"
require "kconv"

NKF_command = '/usr/local/bin/nkf'
SENDMAIL_command = '/usr/sbin/sendmail'
FROM_address = 'TAKAKU.Masao@nims.go.jp'

message = STDIN.read
#puts message

ARGF.each do |line|
   data = line.chomp.split(/\t/)
   next if data.empty?
   result = ERB::new( message ).result( binding )
   puts data[7]
   open("|#{NKF_command} -j -m0 | #{SENDMAIL_command} -oi -t -f #{FROM_address}", "w") do |io|
      io.puts result
   end
end
