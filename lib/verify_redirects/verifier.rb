# frozen_string_literal: true

require 'honey_format'
require 'http'

require 'verify_redirects/result'

module VerifyRedirects
  class Verifier
    attr_reader :results

    def initialize
      @results = []
    end

    def call(from_url, expected_to)
      url = to_url(from_url)
      expected = remove_spaces(expected_to)&.force_encoding('UTF-8')

      puts "GET #{url}" if debug?
      response = Http.get(url)
      # Paths can contain scary characters: 'sa-far-du-ersatt\xE2\x80\xA6marens-flygstrul/'
      location = response.headers['Location']&.force_encoding('UTF-8')
      success = location == expected # if both are nil - no redirect is the success case

      Result.new(
        success: success,
        url: url,
        location: location,
        expected: expected
      ).tap { |r| @results << r }
    end

    private

    def debug?
      VerifyRedirects.config.debug
    end

    def remove_spaces(string)
      string.to_s.gsub(/[[:space:]]/, '')
    end

    def to_url(url, scheme: 'http://')
      url = remove_spaces(url)
      return url if %w[http:// https://].any? { |s| url.start_with?(s) }

      "#{scheme}#{url}"
    end
  end
end
