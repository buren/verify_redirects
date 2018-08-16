# frozen_string_literal: true

require 'verify_redirects/version'
require 'verify_redirects/verifier'

module VerifyRedirects
  def self.from_csv(input_path:, output_path:)
    verifier = Verifier.new

    input_csv = HoneyFormat::CSV.new(File.read(input_path))

    header = %w[success from redirected_to expected_redirect]
    rows = input_csv.rows.map do |row|
      result = verifier.call(row.from_url, row.to_url)
      yield(result) if block_given?
      result.to_a
    end
    output_csv = HoneyFormat::Matrix.new(rows, header: header).to_csv

    File.write(output_path, output_csv)
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.config
    configuration
  end

  def self.configure
    yield(configuration) if block_given?
    configuration
  end

  class Configuration
    attr_accessor :debug

    def initialize
      @debug = false
    end
  end
end
