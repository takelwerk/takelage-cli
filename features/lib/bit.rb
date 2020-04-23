# frozen_string_literal: true

def bit_before_all
  @bitboard_image = 'takelage/bitboard'
  @bitboard_name = 'bitboard-cucumber'
  _start_bitboard
end

def bit_after_all
  _stop_bitboard
end

private

def _start_bitboard
  _crate_bitboard_network
  _start_bitboard_container
  _connect_bitboard_network
end

def _crate_bitboard_network
  cmd_create_network = 'docker network create ' \
      "#{@bitboard_name} " \
      '>/dev/null 2>&1'
  system cmd_create_network
end

def _start_bitboard_container
  cmd_start_bitboard_container = 'docker run ' \
      '--detach ' \
      "--name #{@bitboard_name} " \
      "--network #{@bitboard_name} " \
      '--privileged ' \
      '--rm ' \
      "#{@bitboard_image} " \
      '>/dev/null 2>&1'
  system cmd_start_bitboard_container
end

def _connect_bitboard_network
  cmd_connect_network = 'docker network connect ' \
      "#{@bitboard_name} " \
      "#{ENV['HOSTNAME']} " \
      '>/dev/null 2>&1'
  system cmd_connect_network
end

def _stop_bitboard
  _disconnect_bitboard_network
  _remote_bitboard_network
  _stop_bitboard_container
end

def _disconnect_bitboard_network
  cmd_disconnect_network = 'docker network disconnect ' \
      "#{@bitboard_name} " \
      "#{ENV['HOSTNAME']} " \
      '>/dev/null 2>&1'
  system cmd_disconnect_network
end

def _remote_bitboard_network
  cmd_remove_network = 'docker network rm ' \
      "#{@bitboard_name} " \
      '>/dev/null 2>&1'
  system cmd_remove_network
end

def _stop_bitboard_container
  cmd_stop_bitboard_container = 'docker stop ' \
      "#{@bitboard_name} " \
      '>/dev/null 2>&1'
  system cmd_stop_bitboard_container
end
