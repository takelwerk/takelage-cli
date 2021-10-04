# frozen_string_literal: true

Before do
  _copy_home_config
  _copy_gopass_gpg_tar_gz
  _tar_extract_gopass_gpg_tar_gz
  _create_hg_config
end

# for host.docker.internal see
# https://dev.to/bufferings/access-host-from-a-docker-container-4099
Before '@before_build_mock_images' do
  build_mock_images
end

After '@after_stop_mock_container' do
  stop_mock_container
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

def _create_hg_config
  cmd_create_hg_config = "bash -c '" \
      'echo -e "[ui]\nusername = Cucumber <cucumber@example.com>" > ' \
      "#{aruba.config.home_directory}/.hgrc " \
      "'"
  system cmd_create_hg_config
end
