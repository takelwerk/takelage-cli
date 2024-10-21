# frozen_string_literal: true

Given 'I create my user in the docker container' do
  user = `whoami`
  cmd_create_user = 'docker exec ' \
                    '--interactive ' \
                    'takelage-mock_cucumber_xinot-syzof ' \
                    "/bin/sh -c '" \
                    '/usr/sbin/adduser ' \
                    '--disabled-password ' \
                    '--no-create-home ' \
                    "#{user}'"
  system cmd_create_user
end
