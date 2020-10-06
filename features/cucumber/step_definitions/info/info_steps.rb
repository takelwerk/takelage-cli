# frozen_string_literal: true

Given 'I initialize a gopass workspace' do
  cmd_copy_gopass_gpg_tar_gz = "bash -c '" \
      "cp features/cucumber/support/fixtures/gopass-gpg/gopass-gpg.tar.gz " \
      "#{aruba.config.home_directory}" \
      "'"
  cmd_tar_extract_gopass_gpg_tar_gz = "bash -c '" \
      "cd #{aruba.config.home_directory} && " \
      "tar xvfz gopass-gpg.tar.gz " \
      '&> /dev/null' \
      "'"

  system cmd_copy_gopass_gpg_tar_gz
  system cmd_tar_extract_gopass_gpg_tar_gz
end
