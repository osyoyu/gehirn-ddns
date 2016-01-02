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
