# frozen_string_literal: true

# takelage init packer docker
module InitPackerDocker
  def init_packer_docker
    log.debug 'Initialize packer project for docker images'

    return false unless _init_packer_lib_git_check
    return false unless _init_packer_lib_bit_check
    files = _init_packer_docker_files_get
    return false unless _init_packer_lib_files_check files

    exit_code = true

    exit_code &&= _init_packer_lib_git_init
    exit_code &&= _init_packer_lib_bit_init
    exit_code &&= _init_packer_lib_files_create files
    exit_code &&= _init_packer_lib_git_add_all
    exit_code &&= _init_packer_lib_git_commit_initial

    # reinitialize config with newly created files
    initialize_config

    if config.active['init_packer_docker_bit_require_import'] == 'true'
      log.info "Importing bit components"
      return false unless bit_require_import
    end

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
end
