# frozen_string_literal: true

# takeltau init takelage lib
module InitLib
  private

  # Import bit components.
  def _init_lib_bit_require_import
    if config.active['init_bit_require_import'] == 'true'
      log.info 'Importing bit components'
      return false unless bit_require_import
    end

    true
  end

  # Check bit.
  def _init_lib_bit_check
    return false unless command_available_else_error? config.active['cmd_bit']
    return true unless bit_check_workspace

    log.error 'bit is already initialized!'
    false
  end

  # Init bit.
  def _init_lib_bit_init
    log.info 'Initializing bit workspace'
    return false unless try config.active['cmd_init_lib_bit_init']

    true
  end

  # Check git.
  def _init_lib_git_check
    return false unless command_available_else_error? config.active['cmd_git']
    return true unless git_check_workspace

    log.error 'git is already initialized!'
    false
  end

  # Init git.
  def _init_lib_git_init
    log.info 'Initializing git workspace'
    return false unless try config.active['cmd_init_lib_git_init']

    true
  end

  # Check files.
  def _init_lib_files_check(files)
    exit_status = true
    files.each do |file|
      if _file_exists? file[:name]
        log.error "File exists: #{file[:name]}"
        exit_status = false
      end
    end
    exit_status
  end

  # Create files.
  def _init_lib_files_create(files)
    files.each do |file|
      template file[:template], file[:name]
    end
    true
  end

  # Run git add --all.
  def _init_lib_git_add_all
    log.info 'Preparing initial git commit'
    return false unless try config.active['cmd_init_lib_git_add_all']

    true
  end

  # Run git commit -m "Initial commit".
  def _init_lib_git_commit_initial
    log.info 'Saving initial git commit'
    return false unless try config.active['cmd_init_lib_git_commit_initial']

    true
  end
end
