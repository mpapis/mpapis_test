#!/usr/bin/env ruby

require 'open-uri'
require 'json'

repo = ARGV[0] || "railsinstaller/railsinstaller-nix"
url  = "https://api.github.com/repos/#{repo}/downloads"

open(url) do |res|
  data = JSON.load(res).map{ |file|
    [
      File.basename(file["html_url"]),
      file["download_count"]
    ]
  }
  puts data.map{|touple| touple*" " }
  puts data.map{|name,count| count}.inject(&:+)
end
