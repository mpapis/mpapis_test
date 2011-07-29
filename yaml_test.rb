require 'yaml'

@c = YAML.load(<<-YAML)
---
a: &default
  b: a
  c: d
e:
  <<: *default
  b: g
YAML

puts "#{YAML::ENGINE.yamler}:@c['e']:#{@c['e']}:"
