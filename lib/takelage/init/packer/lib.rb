# frozen_string_literal: true

# takelage info status lib
module InitPackerLib
  private

  def _init_packer_docker_lib_check_prerequisites(files)
    return false unless _init_packer_lib_git_check

    return false unless _init_packer_lib_bit_check

    return false unless _init_packer_lib_files_check files

    true
  end

  def _init_packer_docker_lib_create_project(files)
    exit_code = true

    exit_code &&= _init_packer_lib_git_init
    exit_code &&= _init_packer_lib_bit_init
    exit_code &&= _init_packer_lib_files_create files
    exit_code &&= _init_packer_lib_git_add_all
    exit_code &&= _init_packer_lib_git_commit_initial

    exit_code
  end

  def _init_packer_lib_bit_check
    return false unless command_available_else_error? config.active['cmd_bit']
    return true unless bit_check_workspace

    log.error 'bit is already initialized!'
    false
  end

  def _init_packer_lib_bit_init
    log.info 'Initializing bit workspace'
    return false unless try config.active['cmd_init_packer_lib_bit_init']

    true
  end

  def _init_packer_lib_git_check
    return false unless command_available_else_error? config.active['cmd_git']
    return true unless git_check_workspace

    log.error 'git is already initialized!'
    false
  end

  def _init_packer_lib_git_init
    log.info 'Initializing git workspace'
    return false unless try config.active['cmd_init_packer_lib_git_init']

    true
  end

  def _init_packer_lib_files_check(files)
    exit_status = true
    files.each do |file|
      if _file_exists? file[:name]
        log.error "File exists: #{file[:name]}"
        exit_status = false
      end
    end
    exit_status
  end

  def _init_packer_lib_files_create(files)
    files.each do |file|
      template file[:template], file[:name]
    end
    true
  end

  # git add --all.
  def _init_packer_lib_git_add_all
    log.info 'Preparing initial git commit'
    return false unless try config.active['cmd_init_packer_lib_git_add_all']

    true
  end

  # git commit -m "Initial commit".
  def _init_packer_lib_git_commit_initial
    log.info 'Saving initial git commit'
    return false unless try config.active['cmd_init_packer_lib_git_commit_initial']

    true
  end
end
