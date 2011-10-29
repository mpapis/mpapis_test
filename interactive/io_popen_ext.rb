#!/usr/bin/env ruby

require 'yaml'

def run(bash,command)
  bash.puts "echo =====cmd:start=#{command}"
  bash.puts command
  bash.puts "echo =====cmd:env=#{command}"
  bash.puts "env"
  bash.puts "echo =====cmd:stop=$?=#{command}"
end

def process(output)
  th=Thread.current
  curr="cmd_#{th['current']}".to_sym

  if /=====cmd:start=(.*)/ =~ output
    th[curr]={ :command => $1, :lines => [], :status => nil }

  elsif /=====cmd:env=(.*)/ =~ output
    th[curr][:env]=[]

  elsif /^=====cmd:stop=(.*)=(.*)$/ =~ output
    th[curr][:status]=$1.to_i
    th['current']+=1

  else
    if th[curr][:env].nil?
      th[curr][:lines]+=[output]
    else
      th[curr][:env]+=[output]
    end
  end

  th[curr]
end

puts "Starting interactive session"
IO.popen('bash', 'w+') { |bash|

  treader=Thread.new do
    Thread.current['current']=0

    while !bash.eof?
      result = process bash.gets

      unless result[:status].nil?
        y result
      end
    end
  end

  run bash, 'rvm info'
  run bash, 'export var=2'
  run bash, 'echo "var:$var:"'

  run bash, 'exit'
  treader.join
}
puts "Ending interactive session"
