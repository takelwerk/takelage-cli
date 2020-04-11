Given "I push the latest local docker image" do
  docker_user = @config['docker_user']
  docker_repo = @config['docker_repo']
  tag_latest_local = `HOME=#{aruba.config.home_directory} tau-cli docker image tag latest local`
  image = "#{docker_user}/#{docker_repo}:#{tag_latest_local}"
  cmd_docker_push = 'docker push ' +
      "#{image} " +
      '>/dev/null 2>&1'
  system cmd_docker_push
end

Given "I remove the latest local docker image" do
  docker_user = @config['docker_user']
  docker_repo = @config['docker_repo']
  tag_latest_local = `HOME=#{aruba.config.home_directory} tau-cli docker image tag latest local`
  image = "#{docker_user}/#{docker_repo}:#{tag_latest_local}"
  cmd_docker_rmi = 'docker rmi ' +
      "#{image} " +
      '>/dev/null 2>&1'
  system cmd_docker_rmi
end

Then 'my latest local docker version matches the latest remote docker version' do
  tag_latest_local = `HOME=#{aruba.config.home_directory} tau-cli docker image tag latest local`
  tag_latest_remote = `HOME=#{aruba.config.home_directory} tau-cli docker image tag latest remote`
  expect(tag_latest_local).to eq tag_latest_remote
end
