# frozen_string_literal: true

Given 'I ask docker about the latest remote docker image' do
  docker_user = @config['docker_user']
  user = File.basename docker_user
  docker_repo = @config['docker_repo']
  docker_registry = @config['docker_registry']
  py_print_tags = 'import sys, json; print("\n".join(json.load(sys.stdin)["tags"]))'
  cmd_curl_registry = 'curl --silent ' \
      "#{docker_registry}/v2/#{user}/#{docker_repo}/tags/list " \
      "| python3 -c '#{py_print_tags}' " \
      '| sort --reverse --sort=general-numeric ' \
      '| head -1'
  @tag_latest_remote = `#{cmd_curl_registry}`
end

Then 'the remote images match' do
  expect(last_command_started.output).to eq @tag_latest_remote
end
