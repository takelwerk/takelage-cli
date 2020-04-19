Given 'I create my user in the docker container' do
  user = `whoami`
  cmd_create_user = 'docker exec ' \
      '--interactive ' \
      'takelage-mock_cucumber ' \
      "/bin/sh -c '" \
      '/usr/sbin/adduser ' \
      '--disabled-password ' \
      '--no-create-home ' \
      "#{user}'"
  system cmd_create_user
end