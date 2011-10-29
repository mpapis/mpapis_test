#!/usr/bin/env ruby

require 'yaml'

def run(bash,command)
  bash.puts "echo '=====cmd:start=#{command}'"
  bash.puts command
  bash.puts "echo =====cmd:env="
  bash.puts "env"
  bash.puts "echo =====cmd:stop=$?="
end

def process(output)
  th=Thread.current
  curr="cmd_#{th['current']}".to_sym

  if /^=====cmd:start=(.*)$/ =~ output
    th[curr]={ :command => $1, :lines => [], :status => nil }

  elsif /^=====cmd:env=$/ =~ output
    th[curr][:env]=[]

  elsif /^=====cmd:stop=(.*)=$/ =~ output
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
        puts "--command: #{result[:command]}"
        puts result[:lines]*""
        puts "--returned: #{result[:status]}"
      end
    end
  end

  run bash, 'rvm info #status=0'
  run bash, 'export var=2 #status=0'
  run bash, 'echo "var:$var:" #status'

  run bash, 'exit'
  treader.join
}
puts "Ending interactive session"
