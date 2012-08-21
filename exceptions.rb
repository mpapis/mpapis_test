#!/usr/bin/env ruby

require 'bundler'

def test_me run
  puts "On the start"
  raise Bundler::GemNotFound.new("run") if run
  true
rescue Bundler::BundlerError => e
  puts "On the error:#{e}:"
  false
ensure
  puts "On the end"
end

status=test_me true
puts "test_me true -> #{status}"

status=test_me false
puts "test_me false -> #{status}"
