# frozen_string_literal: true

require 'aruba/cucumber'
require 'json'
require_relative 'container'
require_relative 'image'
ENV['PATH'] = "/project/bin#{File::PATH_SEPARATOR}#{ENV['PATH']}"

# BeforeAll hook
image_before_all

# AfterAll hook
at_exit do
  image_after_all
  container_after_all
end
