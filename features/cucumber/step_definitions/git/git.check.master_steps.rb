# frozen_string_literal: true

Given 'I switch to the git branch named {string} in {string}' do |branch, dir|
  cmd_git_switch_branch = "bash -c '" \
      "cd #{aruba.config.working_directory}/#{dir} && " \
      'git checkout ' \
      "-b #{branch} " \
      '&> /dev/null' \
      "'"
  system cmd_git_switch_branch
end
