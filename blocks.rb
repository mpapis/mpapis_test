#!/usr/bin/env ruby

require 'benchmark'
include Benchmark

def a(&b)
  Benchmark.benchmark(CAPTION) do |x|
    x.report('wow:',&b)
  end
end

a { sleep 1 }
