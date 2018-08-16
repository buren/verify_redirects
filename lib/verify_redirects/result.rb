# frozen_string_literal: true

require 'csv'

module VerifyRedirects
  class Result
    attr_reader :success, :start_url, :redirected_to, :expected_redirect

    def initialize(success:, start_url:, redirected_to:, expected_redirect:)
      @success = success
      @start_url = start_url
      @redirected_to = redirected_to
      @expected_redirect = expected_redirect
    end

    def to_a
      [success, start_url, redirected_to, expected_redirect]
    end
  end
end
