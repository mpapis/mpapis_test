#!/usr/bin/env ruby

class Inst
  def initialize options=nil
    @options = options
    @env_shebang = "fail"
  end
  attr_reader :options
end

def test text, inst
  options_supported = inst.respond_to?('options') && inst.options
  res=options_supported ? inst.options[:env_shebang] : inst.instance_variable_get(:@env_shebang)
  puts "#{text}:#{res}:"
end

test "nil", Inst.new
test "empty", Inst.new({})
test "not set", Inst.new({:env_shebang=>nil})
test "set", Inst.new({:env_shebang=>"shebang"})

