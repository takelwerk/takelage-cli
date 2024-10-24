# frozen_string_literal: true

require 'aruba/cucumber'
require 'json'
require_relative 'container'
require_relative 'image'
ENV['PATH'] = "/project/bin#{File::PATH_SEPARATOR}#{ENV.fetch('PATH', nil)}"

# BeforeAll hook
image_before_all

# AfterAll hook
at_exit do
  image_after_all
  stop_mock_container
  stop_mock_takelship_container
end
