# frozen_string_literal: true

When 'I get the takelage docker socket start commands' do
  cmd_agent_socket_path =
    @config['cmd_docker_socket_config_agent_socket_path']
  cmd_get_agent_socket_path = "HOME=#{aruba.config.home_directory} " \
    "#{cmd_agent_socket_path}"
  agent_socket_path = `#{cmd_get_agent_socket_path}`

  cmd_agent_ssh_socket_path =
    @config['cmd_docker_socket_config_agent_ssh_socket_path']
  cmd_get_agent_ssh_socket_path = "HOME=#{aruba.config.home_directory} " \
    "#{cmd_agent_ssh_socket_path}"
  agent_ssh_socket_path = `#{cmd_get_agent_ssh_socket_path}`

  cmd_socket_start = @config['cmd_docker_socket_get_start']

  @docker_socket_start_commands = []
  @docker_socket_start_commands.push(
    format(
      cmd_socket_start,
      port: @config['docker_socket_gpg_agent_port'],
      host: '127.0.0.1',
      path: agent_socket_path
    )
  )
  @docker_socket_start_commands.push(
    format(
      cmd_socket_start,
      port: @config['docker_socket_gpg_ssh_agent_port'],
      host: '127.0.0.1',
      path: agent_ssh_socket_path
    )
  )
end

Then 'the gpg sockets are started' do
  cmd_processes = 'ps a -o command'
  processes = `#{cmd_processes}`

  @docker_socket_start_commands.each do |command|
    expect(processes).to include(command)
  end
end
