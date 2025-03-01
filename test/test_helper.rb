# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'ipgeobase'
require 'webmock/minitest'
require 'minitest/autorun'
require 'minitest-power_assert'
