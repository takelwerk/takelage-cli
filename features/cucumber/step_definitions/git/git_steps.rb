# frozen_string_literal: true

Given 'I initialize a git workspace in {string}' do |dir|
  cmd_git_init_workspace = "bash -c '" \
                           "HOME=#{aruba.config.home_directory} " \
                           "cd #{aruba.config.working_directory}/#{dir} && " \
                           'git init --initial-branch "main" && ' \
                           '&> /dev/null' \
                           "'"
  system cmd_git_init_workspace
end

Given 'I commit everything in {string} to git' do |dir|
  cmd_git_add = "bash -c '" \
                "HOME=#{aruba.config.home_directory} " \
                "git -C #{aruba.config.working_directory}/#{dir}  " \
                'add --all ' \
                '&> /dev/null' \
                "'"
  cmd_git_commit = "bash -c '" \
                   "HOME=#{aruba.config.home_directory} " \
                   "git -C #{aruba.config.working_directory}/#{dir} " \
                   "commit --message 'Cucumber feature test commit' " \
                   '--quiet ' \
                   '&> /dev/null' \
                   "'"
  system cmd_git_add
  system cmd_git_commit
end

Given 'I switch to the git branch named {string} in {string}' do |branch, dir|
  cmd_git_switch_branch = "bash -c '" \
                          "cd #{aruba.config.working_directory}/#{dir} && " \
                          "HOME=#{aruba.config.home_directory} " \
                          'git checkout ' \
                          "#{branch} " \
                          '&> /dev/null' \
                          "'"
  system cmd_git_switch_branch
end

Given 'I switch to the new git branch named {string} in {string}' do |branch, dir|
  cmd_git_switch_branch = "bash -c '" \
                          "cd #{aruba.config.working_directory}/#{dir} && " \
                          "HOME=#{aruba.config.home_directory} " \
                          'git checkout ' \
                          "-b #{branch} " \
                          '&> /dev/null' \
                          "'"
  system cmd_git_switch_branch
end
