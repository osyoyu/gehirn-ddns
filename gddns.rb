# coding: UTF-8

require 'optparse'
require 'rest-client'

options = {}
OptionParser.new do |opt|
  opt.banner = "Usage: #{$0} [options]"

  opt.on('-c [PATH]', '--config [PATH]') {|v|
    options[:config] = v
  }

  opt.parse!(ARGV)
end
options[:config] ||= "config.json"

config = nil
File.open(options[:config]) {|f|
  config = JSON.parse(f.read)
}

ENDPOINT = "https://#{config["token"]}:#{config["secret"]}@cp.gehirn.jp/api/dns"

request = RestClient.get("#{ENDPOINT}/domain")

puts request.to_str
