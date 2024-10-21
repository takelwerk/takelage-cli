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
  takelage_container_after_all
  takelship_container_after_all
end
