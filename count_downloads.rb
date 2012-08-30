#!/usr/bin/env ruby

require 'open-uri'
require 'json'

repo = ARGV[0] || "railsinstaller/railsinstaller-nix"
url  = "https://api.github.com/repos/#{repo}/downloads"

open(url) do |res|
  sum = 0
  JSON.load(res).each do |file|
    name  = File.basename(file["html_url"])
    count = file["download_count"]
    sum  += count
    puts "#{name} #{count}"
  end
  puts sum
end
