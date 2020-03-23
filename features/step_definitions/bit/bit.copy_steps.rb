Then "there is a bit component named {string} in the remote scope named {string} in {string}" do |component, scope, dir|
  cmd_bit_list  = "bash -c '" +
      "cd #{aruba.config.working_directory}/#{dir} && " +
      "bit list " +
      "--skip-update " +
      "--json " +
      "'"
  bit_components = `#{cmd_bit_list}`
  expect(bit_components).to include "#{scope}/#{component}"
end
