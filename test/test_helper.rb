# require "codeclimate-test-reporter"
# CodeClimate::TestReporter.start

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

require 'support/minitest_reporters'
require "minitest/rails/capybara"

class ActiveSupport::TestCase
  fixtures :all
end
