Before do
  cmd_copy_home_config = "bash -c '" +
      "mkdir -p #{aruba.config.home_directory} && " +
      "cp /homedir/.takelage.yml #{aruba.config.home_directory}/.takelage.yml" +
      "'"
  cmd_copy_ssh_config = "bash -c '" +
      "mkdir -p #{aruba.config.home_directory}/.ssh && " +
      "cp features/fixtures/takelage-bitboard/config #{aruba.config.home_directory}/.ssh/config && " +
      "cp features/fixtures/takelage-bitboard/id_rsa.myuser #{aruba.config.home_directory}/.ssh/id_rsa" +
      "'"
  system cmd_copy_home_config
  system cmd_copy_ssh_config
end

# for host.docker.internal see
# https://dev.to/bufferings/access-host-from-a-docker-container-4099
Before '@before_build_mock_images' do
  build_mock_images
end

After '@after_stop_mock_container' do
  stop_mock_container
end

After '@after_remove_scope_my_scope' do
  cmd_bit_ssh = @config['bit_ssh']
  root = @config['bit_root']
  cmd_bit_scope_remove = @config['cmd_bit_scope_remove_scope'] % {root: root, scope: 'my_scope'}
  system "HOME=#{aruba.config.home_directory} && #{cmd_bit_ssh} '#{cmd_bit_scope_remove}'"
end
