Given 'I ask docker about the latest remote docker image' do
  docker_tagsurl = @config['docker_tagsurl']
  py_print_tags = 'import sys, json; print(json.load(sys.stdin)["tags"][-1])'
  cmd_curl_registry = "curl --silent #{docker_tagsurl} " +
      "| python3 -c '#{py_print_tags}'"
  @tag_latest_remote = `#{cmd_curl_registry}`
end

Then 'the remote images match' do
  expect(last_command_started.output).to eq @tag_latest_remote
end
