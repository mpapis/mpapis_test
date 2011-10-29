#!/usr/bin/env ruby

puts "Starting interactive session"
IO.popen('bash', 'w+') { |bash|
  treader=Thread.new do
    while !bash.eof?
      puts "#{bash.gets}"
    end
  end
  bash.puts 'rvm info'
  bash.puts 'exit'
  treader.join
}
puts "Ending interactive session"
