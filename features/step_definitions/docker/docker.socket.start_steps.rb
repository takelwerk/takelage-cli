# frozen_string_literal: true

When 'I get the takelage docker socket start commands' do
  @docker_socket_start_commands = []
  @docker_socket_start_commands.push(
    _get_socket_start_command(
      @config['cmd_docker_socket_get_start'],
      _get_agent_socket_path,
      @config['docker_socket_gpg_agent_port']
    )
  )
  @docker_socket_start_commands.push(
    _get_socket_start_command(
      @config['cmd_docker_socket_get_start'],
      _get_agent_ssh_socket_path,
      @config['docker_socket_gpg_ssh_agent_port']
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

private

def _get_agent_socket_path
  cmd_agent_socket_path =
    @config['cmd_docker_socket_config_agent_socket_path']
  cmd_get_agent_socket_path = "HOME=#{aruba.config.home_directory} " \
    "#{cmd_agent_socket_path}"
  `#{cmd_get_agent_socket_path}`
end

def _get_agent_ssh_socket_path
  cmd_agent_ssh_socket_path =
    @config['cmd_docker_socket_config_agent_ssh_socket_path']
  cmd_get_agent_ssh_socket_path = "HOME=#{aruba.config.home_directory} " \
    "#{cmd_agent_ssh_socket_path}"
  `#{cmd_get_agent_ssh_socket_path}`
end

def _get_socket_start_command(cmd, path, port)
  format(
    cmd,
    port: port,
    host: '127.0.0.1',
    path: path
  )
end
