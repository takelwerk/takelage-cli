# frozen_string_literal: true

Given 'I initialize a git workspace in {string}' do |dir|
  cmd_git_init_workspace = "bash -c '" \
      "cd #{aruba.config.working_directory}/#{dir} && " \
      'git init --initial-branch "main" && ' \
      'git config user.name "Cucumber" && ' \
      'git config user.email "cucumber@example.com" && ' \
      '&> /dev/null' \
      "'"
  system cmd_git_init_workspace
end

Given 'I commit everything in {string} to git' do |dir|
  cmd_git_add = "bash -c '" \
      "git -C #{aruba.config.working_directory}/#{dir} " \
      ' add --all ' \
      '&> /dev/null' \
      "'"
  cmd_git_commit = "bash -c '" \
      "git -C #{aruba.config.working_directory}/#{dir} " \
      "commit --message 'Cucumber feature test commit' " \
      '--quiet ' \
      '&> /dev/null' \
      "'"
  system cmd_git_add
  system cmd_git_commit
end
