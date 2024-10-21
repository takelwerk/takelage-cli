# frozen_string_literal: true

Given 'I ask docker about the docker images' do
  docker_user = @config['docker_user']
  docker_repo = @config['docker_repo']
  cmd_docker_images = 'docker images  ' \
                      "#{docker_user}/#{docker_repo}  " \
                      '--format "{{.Tag}}"  ' \
                      '| sort --sort=general-numeric '
  @tag_list = `#{cmd_docker_images}`.split(/\n+/).to_s
end

Then 'the list of images match' do
  expect(last_command_started.output.strip).to eq @tag_list
end
