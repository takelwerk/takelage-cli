# frozen_string_literal: true

Given 'I push the takelship image' do
  ship_user = @config['ship_user']
  ship_repo = @config['ship_repo']
  image = "#{ship_user}/#{ship_repo}:latest"
  cmd_docker_push = 'docker push ' \
                    "#{image} " \
                    '>/dev/null 2>&1'
  system cmd_docker_push
end

Given 'I remove the takelship image' do
  ship_user = @config['ship_user']
  ship_repo = @config['ship_repo']
  image = "#{ship_user}/#{ship_repo}:latest"
  cmd_docker_rmi = 'docker rmi ' \
                   "#{image} " \
                   '>/dev/null 2>&1'
  system cmd_docker_rmi
end

Then 'I downloaded the takelship image' do
  ship_user = @config['ship_user']
  ship_repo = @config['ship_repo']
  image = "#{ship_user}/#{ship_repo}:latest"
  cmd_docker_image = "docker image ls #{image} --quiet"
  result_takelship_image = `#{cmd_docker_image}`
  expect(result_takelship_image).not_to be_empty
end
