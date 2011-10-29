#!/usr/bin/env ruby

require 'yaml'

def run(bash,command)
  bash.puts "echo =====cmd:start=#{command}"
  bash.puts command
  bash.puts "echo =====cmd:stop=$?=#{command}"
end

def process(output)
  th=Thread.current
  if /=====cmd:start=(.*)/ =~ output
    th['current']||=0
    th['current']+=1
    curr="cmd_#{th['current']}".to_sym
    th[curr]={:command => $1}
  elsif /^=====cmd:stop=(.*)=(.*)$/ =~ output
    curr="cmd_#{th['current']}".to_sym
    th[curr][:status]=$1.to_i
    y th[curr]
  else
    curr="cmd_#{th['current']}".to_sym
    th[curr][:lines]||=[]
    th[curr][:lines]+=[output]
  end
end

puts "Starting interactive session"
IO.popen('bash', 'w+') { |bash|
  treader=Thread.new do
    while !bash.eof?
      process bash.gets
    end
  end
  run bash, 'rvm info 1'
  run bash, 'rvm info 2'
  run bash, 'rvm info 3'
  run bash, 'exit'
  treader.join
#  [0...treader['current']].each do |n|
#    curr="cmd_#{n}".to_sym
#    y treader[curr]
#  end
}
puts "Ending interactive session"
