#!/usr/bin/env ruby
# concatenate any number of random forest models to stdout.

HEADER_SIZE = 5
gross_length = %x[wc -l #{ARGV.join(" ")}][/(\d+) total/, 1].to_i
real_length = gross_length - HEADER_SIZE*ARGV.size
# STDERR.puts gross_length
# STDERR.puts real_length

header = %x[head -#{HEADER_SIZE} #{ARGV[0]}]
header.gsub!(/^trees:.*/, "trees: #{real_length}")
STDERR.puts header

puts header
for f in ARGV
  system "tail -n+#{HEADER_SIZE+1} #{f}"
end
