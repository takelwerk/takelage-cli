# frozen_string_literal: true

Given 'I push the local docker image {string}' do |tag|
  docker_user = @config['docker_user']
  docker_repo = @config['docker_repo']
  image = "#{docker_user}/#{docker_repo}:#{tag}"
  cmd_docker_push = 'docker push ' \
      "#{image} " \
      '>/dev/null 2>&1'
  system cmd_docker_push
end

Given 'I remove the local docker image {string}' do |tag|
  docker_user = @config['docker_user']
  docker_repo = @config['docker_repo']
  image = "#{docker_user}/#{docker_repo}:#{tag}"
  cmd_docker_rmi = 'docker rmi ' \
      "#{image} " \
      '>/dev/null 2>&1'
  system cmd_docker_rmi
end

Given 'I push the latest local docker image' do
  docker_user = @config['docker_user']
  docker_repo = @config['docker_repo']
  cmd_tag_latest_local = "HOME=#{aruba.config.home_directory} " \
    'tau-cli docker image tag latest local'
  tag_latest_local = `#{cmd_tag_latest_local}`
  image = "#{docker_user}/#{docker_repo}:#{tag_latest_local}"
  cmd_docker_push = 'docker push ' \
      "#{image} " \
      '>/dev/null 2>&1'
  system cmd_docker_push
end

Given 'I remove the latest local docker image' do
  docker_user = @config['docker_user']
  docker_repo = @config['docker_repo']
  cmd_tag_latest_local = "HOME=#{aruba.config.home_directory} " \
    'tau-cli docker image tag latest local'
  tag_latest_local = `#{cmd_tag_latest_local}`
  image = "#{docker_user}/#{docker_repo}:#{tag_latest_local}"
  cmd_docker_rmi = 'docker rmi ' \
      "#{image} " \
      '>/dev/null 2>&1'
  system cmd_docker_rmi
end

Given 'I remove all local docker images' do
  docker_user = @config['docker_user']
  docker_repo = @config['docker_repo']
  image_latest = "#{docker_user}/#{docker_repo}:latest"
  cmd_docker_rmi_latest = 'docker rmi ' \
      "#{image_latest} " \
      '>/dev/null 2>&1'
  system cmd_docker_rmi_latest
  cmd_tags_local_json = "HOME=#{aruba.config.home_directory} " \
    'tau-cli docker image tag list local'
  tags_local_json = `#{cmd_tags_local_json}`.chomp
  tags_local = JSON.parse tags_local_json
  tags_local.each do |tag_local|
    image_local = "#{docker_user}/#{docker_repo}:#{tag_local}"
    cmd_docker_rmi_local = 'docker rmi ' \
        "#{image_local} " \
        '>/dev/null 2>&1'
    system cmd_docker_rmi_local
  end
end

Given 'I remove all local docker images but not {string}' do |tag|
  docker_user = @config['docker_user']
  docker_repo = @config['docker_repo']
  cmd_tags_local_json = "HOME=#{aruba.config.home_directory} " \
    'tau-cli docker image tag list local'
  tags_local_json = `#{cmd_tags_local_json}`.chomp
  tags_local = JSON.parse tags_local_json
  tags_local.each do |tag_local|
    next if tag_local == tag

    image = "#{docker_user}/#{docker_repo}:#{tag_local}"
    cmd_docker_rmi = 'docker rmi ' \
        "#{image} " \
        '>/dev/null 2>&1'
    system cmd_docker_rmi
  end
end

Then 'my latest local docker version should be {string}' do |tag|
  cmd_tag_latest_local = "HOME=#{aruba.config.home_directory} " \
    'tau-cli docker image tag latest local'
  tag_latest_local = `#{cmd_tag_latest_local}`
  expect(tag_latest_local).to eq tag
end
