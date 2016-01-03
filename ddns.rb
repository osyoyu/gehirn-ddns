# coding: UTF-8

require 'pp'
require 'optparse'
require_relative './gehirndns.rb'

options = {}
OptionParser.new do |opt|
  opt.banner = "Usage: #{$0} [options]"

  opt.on('-c [PATH]', '--config [PATH]') {|v|
    options[:config_path] = v
  }

  opt.parse!(ARGV)
end
options[:config_path] ||= "#{File.dirname(__FILE__)}/config.json"

config = {}
File.open(options[:config_path]) {|f|
  config = JSON.parse(f.read)
}

gdns = GehirnDNS.new(
  token: config["token"],
  secret: config["secret"],
)

domain = gdns.domains.select {|d| d.name == config["domain"] }.first
STDERR.print "Updating #{config["domain"]}..."
gdns.create_a(domain, config["hostname"], "auto", 300)
STDERR.puts "Done."
