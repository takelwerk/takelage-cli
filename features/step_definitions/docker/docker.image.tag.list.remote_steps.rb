Given 'I ask docker about the remote docker images' do
  docker_tagsurl = @config['docker_tagsurl']
  py_print_tags = 'import sys, json; print(json.load(sys.stdin)["tags"])'
  cmd_curl_registry = "curl --silent #{docker_tagsurl} " +
      "| python3 -c '#{py_print_tags}'"
  raw_tag_list_remote = `#{cmd_curl_registry}`.gsub "'", '"'
  @tag_list_remote = JSON.parse(raw_tag_list_remote).sort.to_s
end

Then 'the list of remote images match' do
  expect(last_command_started.output.strip).to eq @tag_list_remote
end
