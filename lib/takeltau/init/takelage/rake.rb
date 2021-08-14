# frozen_string_literal: true

# takeltau init takelage rake
module InitTakelageRake
  # Backend method for init takelage rake.
  # @return [Boolean] successful init?
  def init_takelage_rake
    log.debug 'Initialize takelage rake project'

    files = _init_takelage_rake_files_get

    return false unless _init_takelage_rake_check_prerequisites files

    exit_code = _init_takelage_rake_create_project files

    # reinitialize config with newly created files
    initialize_config

    return false unless _init_lib_bit_require_import

    return false unless exit_code

    true
  end

  private

  # Add templates.
  def _init_takelage_rake_files_get
    [
      @bitrequireyml,
      @gitignore,
      @projectyml,
      @rakefile
    ]
  end

  # Check prerequisites.
  def _init_takelage_rake_check_prerequisites(files)
    return false unless _init_lib_git_check

    return false unless _init_lib_bit_check

    return false unless _init_lib_files_check files

    true
  end

  # Create project.
  def _init_takelage_rake_create_project(files)
    exit_code = true

    exit_code &&= _init_lib_git_init
    exit_code &&= _init_lib_bit_init
    exit_code &&= _init_lib_files_create files
    exit_code &&= _init_lib_git_add_all
    exit_code &&= _init_lib_git_commit_initial

    exit_code
  end
end
