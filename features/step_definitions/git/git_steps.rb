Given 'I initialize a git workspace in {string}' do |dir|
  cmd_bit_init_workspace = "bash -c '" +
      "git init #{aruba.config.working_directory}/#{dir}" +
      "'"

  system cmd_bit_init_workspace
end
