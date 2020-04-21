# frozen_string_literal: true

Given 'I ask docker about the remote docker images' do
  docker_user = @config['docker_user']
  user = File.basename docker_user
  docker_repo = @config['docker_repo']
  docker_registry = @config['docker_registry']
  py_print_tags = 'import sys, json; print("\n".join(json.load(sys.stdin)["tags"]))'
  cmd_curl_registry = 'curl --silent ' +
      "#{docker_registry}/v2/#{user}/#{docker_repo}/tags/list " +
      "| python3 -c '#{py_print_tags}' " +
      '| sort --sort=general-numeric '
  raw_tag_list_remote = `#{cmd_curl_registry}`.chomp.split "\n"
  @tag_list_remote = raw_tag_list_remote.to_json.to_s.gsub ',', ', '
end

Then 'the list of remote images match' do
  expect(last_command_started.output.strip).to eq @tag_list_remote
end
