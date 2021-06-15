# frozen_string_literal: true

# takelage init packer docker
module InitPackerDocker
  # Backend method for init docker packer.
  # @return [Boolean] successful init?
  def init_packer_docker
    log.debug 'Initialize packer project for docker images'

    files = _init_packer_docker_files_get

    return false unless _init_packer_docker_check_prerequisites files

    exit_code = _init_packer_docker_create_project files

    # reinitialize config with newly created files
    initialize_config

    return false unless _init_lib_bit_require_import

    return false unless exit_code

    true
  end

  private

  # Add templates.
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

  # Check prerequisites.
  def _init_packer_docker_check_prerequisites(files)
    return false unless _init_lib_git_check

    return false unless _init_lib_bit_check

    return false unless _init_lib_files_check files

    true
  end

  # Create project.
  def _init_packer_docker_create_project(files)
    exit_code = true

    exit_code &&= _init_lib_git_init
    exit_code &&= _init_lib_bit_init
    exit_code &&= _init_lib_files_create files
    exit_code &&= _init_lib_git_add_all
    exit_code &&= _init_lib_git_commit_initial

    exit_code
  end
end
