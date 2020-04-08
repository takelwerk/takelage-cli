def build_mock_images
  @image_name = "host.docker.internal:5005/takelage-mock"
  @versions = ['0.0.3', '0.1.0', 'latest', 'prod']
  @versions.each do |version|
    cmd_docker_image = 'docker images ' +
        '--quiet ' +
        "#{@image_name}:#{version}"
    docker_image = `#{cmd_docker_image}`
    if docker_image.to_s.empty?
      cmd_build_mock_image = 'docker build ' +
          "--build-arg version=#{version} " +
          "--tag #{@image_name}:#{version} " +
          "features/fixtures/takelage-mock " +
          '&> /dev/null'
      system cmd_build_mock_image
    end
  end
end

def _start_registry
  cmd_start_registry = 'docker run ' +
      '--detach ' +
      "--name #{@registry_name} " +
      "--publish 5005:5000 " +
      '--rm ' +
      "#{@registry_image} " +
      '&> /dev/null'
  system cmd_start_registry
end

def _stop_registry
  cmd_stop_registry = 'docker stop ' +
      "#{@registry_name} " +
      '&> /dev/null'
  system cmd_stop_registry
end

def image_before_all
  @registry_image = 'registry'
  @registry_name = 'registry-cucumber'
  _start_registry
end

def image_after_all
  _stop_registry
end
