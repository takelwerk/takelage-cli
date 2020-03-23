Then 'the gpg sockets are stopped' do
  cmd_processes = 'ps a -o command'
  processes = `#{cmd_processes}`

  @docker_socket_start_commands.each do |command|
    expect(processes).not_to include(command)
  end
end
