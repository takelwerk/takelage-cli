# frozen_string_literal: true

Given 'I delete a network device named {string}' do |device|
  cmd_device_exists = "ip link show dev #{device}"
  cmd_device_delete = "sudo ip link delete #{device}"
  system cmd_device_delete if system cmd_device_exists
end
