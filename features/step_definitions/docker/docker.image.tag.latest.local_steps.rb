# frozen_string_literal: true

Given 'I ask docker about the latest local docker image' do
  docker_user = @config['docker_user']
  docker_repo = @config['docker_repo']
  cmd_docker_images = 'docker images ' \
      " #{docker_user}/#{docker_repo} " \
      ' --format "{{.Tag}}" ' \
      ' | sort --reverse --sort=general-numeric ' \
      ' | head -1'
  @tag_latest_local = `#{cmd_docker_images}`
end

Then 'the local images match' do
  expect(last_command_started.output).to eq @tag_latest_local
end
