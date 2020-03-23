Given 'I ask docker about the local docker images' do
  docker_repo = @config['docker_repo']
  docker_image = @config['docker_image']
  cmd_docker_images = 'docker images ' +
      " | grep #{docker_repo}/#{docker_image} " +
      " | awk '{print $2}' " +
      " | awk '{print $NF}' "
  @tag_list_local = `#{cmd_docker_images}`.split(/\n+/).sort.to_s
end

Then 'the list of local images match' do
  expect(last_command_started.output.strip).to eq @tag_list_local
end
