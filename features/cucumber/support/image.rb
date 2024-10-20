# frozen_string_literal: true

def build_mock_images
  @takelage_image_name = 'host.docker.internal:5005/takelage-mock/takelage-mock'
  @takelship_image_name = 'host.docker.internal:5005/takelage-mock/takelship-mock'
  _build_mock_takelage_images
  _build_mock_takelship_image
end

def image_before_all
  @registry_image = 'registry'
  @registry_name = 'registry-cucumber'
  _start_registry
end

def image_after_all
  @takelage_image_name = 'host.docker.internal:5005/takelage-mock/takelage-mock'
  @takelship_image_name = 'host.docker.internal:5005/takelage-mock/takelship-mock'
  _stop_registry
  _remove_mock_takelage_images
  _remove_mock_takelship_image
end

private

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

def _build_mock_takelage_images
  %w[0.0.3 0.1.0 prod].each do |version|
    cmd_build_mock_image = 'docker build ' \
      "--build-arg version=#{version} " \
      "--tag #{@takelage_image_name}:#{version} " \
      'features/cucumber/support/fixtures/takelage-mock ' \
      '>/dev/null 2>&1'
    system cmd_build_mock_image
  end
  cmd_tag_mock_latest = 'docker tag ' \
    "#{@takelage_image_name}:0.1.0 " \
    "#{@takelage_image_name}:latest " \
    '>/dev/null 2>&1'
  system cmd_tag_mock_latest
end

def _build_mock_takelship_image
  cmd_build_mock_image = 'docker build ' \
    '--build-arg version=latest ' \
    "--tag #{@takelship_image_name}:latest " \
    'features/cucumber/support/fixtures/takelship-mock ' \
    '>/dev/null 2>&1'
  system cmd_build_mock_image
end

def _remove_mock_takelage_images
  cmd_remove_mock_images = 'docker image remove ' \
    "#{@takelage_image_name}:latest " \
    "#{@takelage_image_name}:prod " \
    "#{@takelage_image_name}:0.1.0 " \
    "#{@takelage_image_name}:0.0.3 " \
    '>/dev/null 2>&1'
  system cmd_remove_mock_images
end

def _remove_mock_takelship_image
  cmd_remove_mock_image = 'docker image remove ' \
    "#{@takelship_image_name}:latest " \
    '>/dev/null 2>&1'
  system cmd_remove_mock_image
end
