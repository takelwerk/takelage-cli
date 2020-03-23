require 'aruba/cucumber'
require 'json'
require_relative '../lib/bit'
require_relative '../lib/container'
require_relative '../lib/image'
ENV['PATH'] = '/project/bin' + File::PATH_SEPARATOR + ENV['PATH']

# BeforeAll hook
bit_before_all
image_before_all

# AfterAll hook
at_exit do
  image_after_all
  container_after_all
  bit_after_all
end
