# frozen_string_literal: true

Given 'I create a network device named {string}' do |device|
  cmd_device_exists = "ip link show dev #{device}"
  cmd_device_create = "sudo ip link add dev #{device} type veth"
  cmd_device_addr = "sudo ip addr add 10.0.111.222/24 dev #{device}"
  unless system cmd_device_exists
    system cmd_device_create
    system cmd_device_addr
  end
end
