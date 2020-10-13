# frozen_string_literal: true

Before do
  _copy_home_config
  _copy_ssh_config
  _copy_gopass_gpg_tar_gz
  _tar_extract_gopass_gpg_tar_gz
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
  cmd_bit_scope_remove = format(
    @config['cmd_bit_scope_remove_scope'],
    root: root,
    scope: 'my_scope'
  )
  system "HOME=#{aruba.config.home_directory} && " \
    "#{cmd_bit_ssh} '#{cmd_bit_scope_remove}'"
end

private

def _copy_home_config
  cmd_copy_home_config = "bash -c '" \
      "mkdir -p #{aruba.config.home_directory} && " \
      'test -f /hostdir/.takelage.yml && ' \
      'cp /hostdir/.takelage.yml ' \
      "#{aruba.config.home_directory}/.takelage.yml" \
      "'"
  system cmd_copy_home_config
end

def _copy_ssh_config
  cmd_copy_ssh_config = "bash -c '" \
      "mkdir -p #{aruba.config.home_directory}/.ssh && " \
      'cp features/cucumber/support/fixtures/takelage-bitboard/config ' \
      "#{aruba.config.home_directory}/.ssh/config && " \
      'cp features/cucumber/support/fixtures/takelage-bitboard/id_rsa.myuser ' \
      "#{aruba.config.home_directory}/.ssh/id_rsa" \
      "'"
  system cmd_copy_ssh_config
end

def _copy_gopass_gpg_tar_gz
  cmd_copy_gopass_gpg_tar_gz = "bash -c '" \
      'cp features/cucumber/support/fixtures/gopass-gpg/gopass-gpg.tar.gz ' \
      "#{aruba.config.home_directory}" \
      "'"
  system cmd_copy_gopass_gpg_tar_gz
end

def _tar_extract_gopass_gpg_tar_gz
  cmd_tar_extract_gopass_gpg_tar_gz = "bash -c '" \
      "cd #{aruba.config.home_directory} && " \
      'tar xvfz gopass-gpg.tar.gz ' \
      '&> /dev/null' \
      "'"
  system cmd_tar_extract_gopass_gpg_tar_gz
end
