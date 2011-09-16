#!/usr/bin/env ruby

puts '1a'
$PROGRAM_NAME='ala'
puts '1b'
eval File.read('test_PROGRAM_NAME_2.rb'), binding, 'test_PROGRAM_NAME_2.rb'
puts '1c'
