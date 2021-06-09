# frozen_string_literal: true

# takelage init packer docker
module InitPackerDocker
  def init_packer_docker
    log.debug 'Initialize packer project for docker images'

    files = _init_packer_docker_files_get

    return false unless _init_packer_docker_lib_check_prerequisites files

    exit_code = _init_packer_docker_lib_create_project files

    # reinitialize config with newly created files
    initialize_config

    return false unless _init_packer_docker_bit_require_import

    return false unless exit_code

    true
  end

  private

  def _init_packer_docker_files_get
    [
      @ansiblelint,
      @bitrequireyml,
      @gitignore,
      @groupvarsprojectyml,
      @playbooksiteyml,
      @projectyml,
      @rakefile
    ]
  end

  def _init_packer_docker_bit_require_import
    if config.active['init_packer_docker_bit_require_import'] == 'true'
      log.info 'Importing bit components'
      return false unless bit_require_import
    end

    true
  end
end
