# frozen_string_literal: true

def build_mock_images
  image_name = 'host.docker.internal:5005/takelage-mock/takelage-mock'
  _build_mock_image_versions image_name
  _build_mock_image_latest image_name
end

def image_before_all
  @registry_image = 'registry'
  @registry_name = 'registry-cucumber'
  _start_registry
end

def image_after_all
  _stop_registry
end

private

def _build_mock_image_versions(image_name)
  versions = %w[0.0.3 0.1.0 prod]
  versions.each do |version|
    cmd_docker_image = 'docker images ' \
        '--quiet ' \
        "#{image_name}:#{version}"
    docker_image = `#{cmd_docker_image}`
    next unless docker_image.to_s.empty?

    _build_mock_image_version image_name, version
  end
end

def _build_mock_image_version(image_name, version)
  cmd_build_mock_image = 'docker build ' \
          "--build-arg version=#{version} " \
          "--tag #{image_name}:#{version} " \
          'features/cucumber/support/fixtures/takelage-mock ' \
          '>/dev/null 2>&1'
  system cmd_build_mock_image
end

def _build_mock_image_latest(image_name)
  cmd_tag_mock_latest = 'docker tag ' \
      "#{image_name}:0.1.0 " \
      "#{image_name}:latest " \
      '>/dev/null 2>&1'
  system cmd_tag_mock_latest
end

def _start_registry
  cmd_start_registry = 'docker run ' \
      '--detach ' \
      "--name #{@registry_name} " \
      '--publish 5005:5000 ' \
      '--rm ' \
      "#{@registry_image} " \
      '>/dev/null 2>&1'
  system cmd_start_registry
end

def _stop_registry
  cmd_stop_registry = 'docker stop ' \
      "#{@registry_name} " \
      '>/dev/null 2>&1'
  system cmd_stop_registry
end
