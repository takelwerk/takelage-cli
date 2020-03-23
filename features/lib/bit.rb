def _start_bitboard
  cmd_start_bitboard = 'docker run ' +
      '--detach ' +
      "--name #{@bitboard_name} " +
      "--privileged " +
      "--publish 2022:222 " +
      '--rm ' +
      "#{@bitboard_image} " +
      '&> /dev/null'
  system cmd_start_bitboard
end

def _stop_bitboard
  cmd_stop_bitboard = 'docker stop ' +
      "#{@bitboard_name} " +
      '&> /dev/null'
  system cmd_stop_bitboard
end

def bit_before_all
  @bitboard_image = 'packer_local/bit-components:dev'
  @bitboard_name = 'bitboard-cucumber'
  _start_bitboard
end

def bit_after_all
  _stop_bitboard
end
