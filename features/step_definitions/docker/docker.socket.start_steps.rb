When 'I get the takelage docker socket start commands' do
  cmd_gpgconf_listdirs = @config['cmd_docker_get_socket_paths_docker_socket_gpgconf']
  gpgconf_listdirs = `HOME=#{aruba.config.home_directory} #{cmd_gpgconf_listdirs} | grep agent`

  cmd_socket_start = @config['cmd_docker_get_socket_start_commands_docker_socket_start']

  @docker_socket_start_commands = []

  gpgconf_listdirs.split("\n").each do |line|
    key_value = line.split(':')
    key = key_value[0]
    path = key_value[1]
    case key
    when 'agent-socket'
      port = @config['docker_socket_agent_port']
    when 'agent-ssh-socket'
      port = @config['docker_socket_agent_ssh_port']
    when 'agent-extra-socket'
      port = @config['docker_socket_agent_extra_port']
    when 'agent-browser-socket'
      port = @config['docker_socket_agent_browser_port']
    end
    @docker_socket_start_commands << cmd_socket_start % {port: port,
                                    host: '127.0.0.1',
                                    path: path}
  end
end

Then 'the gpg sockets are started' do
  cmd_processes = 'ps a -o command'
  processes = `#{cmd_processes}`

  @docker_socket_start_commands.each do |command|
    expect(processes).to include(command)
  end
end
