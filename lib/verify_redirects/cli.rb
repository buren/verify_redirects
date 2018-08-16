# frozen_string_literal: true

require 'optparse'

module VerifyRedirects
  class CLI
    def self.parse(argv:, name:)
      options = {}
      OptionParser.new do |parser|
        parser.banner = "Usage: #{name} --help"
        parser.default_argv = argv

        parser.on('--input=val0', String, "CSV file path (required) - must be a file with two columns: from_url, to_url (order doesn't matter)") do |string|
          options[:input] = string
        end

        parser.on('--output=val0', String, 'CSV output path (optional)') do |string|
          options[:output] = string
        end

        parser.on('--[no-]debug', 'Print debug output (default: false)') do |boolean|
          options[:debug] = boolean
        end

        parser.on('-h', '--help', 'How to use') do
          puts parser
          exit
        end
      end.parse!

      options
    end
  end
end
