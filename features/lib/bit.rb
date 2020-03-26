def _start_bitboard
  cmd_start_bitboard = 'docker run ' +
      '--detach ' +
      "--name #{@bitboard_name} " +
      "--network #{@bitboard_name} " +
      "--privileged " +
      '--rm ' +
      "#{@bitboard_image} " +
      '&> /dev/null'
  cmd_create_network = 'docker network create ' +
      "#{@bitboard_name} " +
      '&> /dev/null'
  cmd_connect_network = 'docker network connect ' +
      "#{@bitboard_name} " +
      "#{ENV['HOSTNAME']} " +
      '&> /dev/null'
  system cmd_create_network
  system cmd_start_bitboard
  system cmd_connect_network
end

def _stop_bitboard
  cmd_disconnect_network = 'docker network disconnect ' +
      "#{@bitboard_name} " +
      "#{ENV['HOSTNAME']} " +
      '&> /dev/null'
  cmd_remove_network = 'docker network rm ' +
      "#{@bitboard_name} " +
      '&> /dev/null'
  cmd_stop_bitboard = 'docker stop ' +
      "#{@bitboard_name} " +
      '&> /dev/null'
  system cmd_disconnect_network
  system cmd_stop_bitboard
  system cmd_remove_network
end

def bit_before_all
  @bitboard_image = 'takelage/bitboard'
  @bitboard_name = 'bitboard-cucumber'
  _start_bitboard
end

def bit_after_all
  _stop_bitboard
end
