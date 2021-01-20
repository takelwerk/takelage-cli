# frozen_string_literal: true

Given 'I push the docker image {string}' do |tag|
  docker_user = @config['docker_user']
  docker_repo = @config['docker_repo']
  image = "#{docker_user}/#{docker_repo}:#{tag}"
  cmd_docker_push = 'docker push ' \
      "#{image} " \
      '>/dev/null 2>&1'
  system cmd_docker_push
end

Given 'I remove the docker image {string}' do |tag|
  docker_user = @config['docker_user']
  docker_repo = @config['docker_repo']
  image = "#{docker_user}/#{docker_repo}:#{tag}"
  cmd_docker_rmi = 'docker rmi ' \
      "#{image} " \
      '>/dev/null 2>&1'
  system cmd_docker_rmi
end

Given 'I push the latest docker image' do
  docker_user = @config['docker_user']
  docker_repo = @config['docker_repo']
  cmd_tag_latest = "HOME=#{aruba.config.home_directory} " \
    'tau-cli docker image tag latest'
  tag_latest = `#{cmd_tag_latest}`.chomp
  image = "#{docker_user}/#{docker_repo}:#{tag_latest}"
  cmd_docker_push = 'docker push ' \
      "#{image} " \
      '>/dev/null 2>&1'
  system cmd_docker_push
end

Given 'I remove the latest docker image' do
  docker_user = @config['docker_user']
  docker_repo = @config['docker_repo']
  cmd_tag_latest = "HOME=#{aruba.config.home_directory} " \
    'tau-cli docker image tag latest'
  tag_latest = `#{cmd_tag_latest}`.chomp
  image = "#{docker_user}/#{docker_repo}:#{tag_latest}"
  cmd_docker_rmi = 'docker rmi ' \
      "#{image} " \
      '>/dev/null 2>&1'
  system cmd_docker_rmi
end

Given 'I remove all docker images' do
  docker_user = @config['docker_user']
  docker_repo = @config['docker_repo']
  image_latest = "#{docker_user}/#{docker_repo}:latest"
  cmd_docker_rmi_latest = 'docker rmi ' \
      "#{image_latest} " \
      '>/dev/null 2>&1'
  system cmd_docker_rmi_latest
  cmd_tags_json = "HOME=#{aruba.config.home_directory} " \
    'tau-cli docker image tag list'
  tags_json = `#{cmd_tags_json}`.chomp
  tags = JSON.parse tags_json
  tags.each do |tag|
    image = "#{docker_user}/#{docker_repo}:#{tag}"
    cmd_docker_rmi = 'docker rmi ' \
        "#{image} " \
        '>/dev/null 2>&1'
    system cmd_docker_rmi
  end
end

Given 'I remove all docker images but not {string}' do |excpetion_tag|
  docker_user = @config['docker_user']
  docker_repo = @config['docker_repo']
  cmd_tags_json = "HOME=#{aruba.config.home_directory} " \
    'tau-cli docker image tag list'
  tags_json = `#{cmd_tags_json}`.chomp
  tags = JSON.parse tags_json
  tags.each do |tag|
    next if tag == excpetion_tag

    image = "#{docker_user}/#{docker_repo}:#{tag}"
    cmd_docker_rmi = 'docker rmi ' \
        "#{image} " \
        '>/dev/null 2>&1'
    system cmd_docker_rmi
  end
end

Then 'my latest local docker image should be {string}' do |tag|
  cmd_tag_latest = "HOME=#{aruba.config.home_directory} " \
    'tau-cli docker image tag latest'
  tag_latest = `#{cmd_tag_latest}`.chomp
  expect(tag).to eq tag_latest
end
