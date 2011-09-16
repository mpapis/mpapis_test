
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

puts "@c['e']:#{@c['e']}:"