# frozen_string_literal: true

Given 'the docker container {string} doesn\'t exist' do |container|
  cmd_docker_existing = 'docker ps ' \
      '--all ' \
      "--filter name=^#{container}$ "\
      '--quiet'
  docker_existing = `#{cmd_docker_existing}`
  expect(docker_existing).to be_empty
end

Then 'the docker container {string} exists' do |container|
  cmd_docker_existing = 'docker ps ' \
    '--all ' \
    "--filter name=^#{container}$ "\
    '--quiet'
  docker_existing = `#{cmd_docker_existing}`
  expect(docker_existing).not_to be_empty
end
