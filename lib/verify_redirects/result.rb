# frozen_string_literal: true

require 'csv'

module VerifyRedirects
  class Result
    attr_reader :success, :url, :location, :expected

    def initialize(success:, url:, location:, expected:)
      @success = success
      @url = url
      @location = location
      @expected = expected
    end

    def to_a
      [success, url, location, expected]
    end
  end
end
