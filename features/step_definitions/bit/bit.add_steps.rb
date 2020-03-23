Given "there is a local remote scope named {string} in {string}" do |remote, dir|
  cmd_bit_remotes  = "bash -c '" +
      "cd #{aruba.config.working_directory}/#{dir} && " +
      "bit remote " +
      "--skip-update " +
      "'"
  bit_remotes = `#{cmd_bit_remotes}`
  expect(bit_remotes).to include "#{remote}"
end

Given "a local remote scope named {string} in {string} should not exist" do |remote, dir|
  cmd_bit_remotes  = "bash -c '" +
      "cd #{aruba.config.working_directory}/#{dir} && " +
      "bit remote " +
      "--skip-update " +
      "'"
  bit_remotes = `#{cmd_bit_remotes}`
  expect(bit_remotes).not_to include "#{remote}"
end