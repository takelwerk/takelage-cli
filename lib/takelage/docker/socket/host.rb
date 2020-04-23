# frozen_string_literal: true

# takelage docker socket host
module DockerSocketHost
  # Backend method for docker socket host.
  def docker_socket_host
    log.debug 'Getting docker socket host ip address'

    socket_host = '127.0.0.1'

    addr_infos = Socket.getifaddrs

    # if interface docker0 exists (== linux host)
    # then return the ip address
    addr_infos.each do |addr_info|
      if addr_info.name == 'docker0'
        socket_host = addr_info.addr.ip_address if addr_info.addr.ipv4?
      end
    end

    log.debug "Docker socket host ip address is \"#{socket_host}\""

    socket_host
  end
end
