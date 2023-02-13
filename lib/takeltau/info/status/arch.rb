# frozen_string_literal: true

# tau info status arch
module InfoStatusArch
  # Backend method for info status arch.
  # @return [String] get cpu architecture
  def info_status_arch
    log.debug 'Get cpu architecture'

    architecture = _info_status_arch_get_architecture.to_sym
    # rubocop:disable Naming/VariableNumber
    architectures = { arm64: 'arm64', aarch64: 'arm64', x86_64: 'amd64' }
    # rubocop:enable Naming/VariableNumber
    unless architectures.key? architecture
      log.error 'cpu architecture unknown'
      return false
    end

    arch = architectures[architecture]
    log.debug "CPU architecture is #{arch}"
    arch
  end

  private

  # Get gopass root store
  def _info_status_arch_get_architecture
    cmd_get_arch = config.active['cmd_info_status_arch_get_arch']
    (run cmd_get_arch).chomp
  end
end
