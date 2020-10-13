# frozen_string_literal: true

# takelage project module
module ProjectModule
  # takelage config class.
  class TakelageProject
    include Singleton
    include LoggingModule
    include SystemModule
    include ConfigModule

    attr_accessor :active, :private, :main

    def initialize
      @active = {}
      @private = {}
      @main = {}
    end
  end

  # Initialze project
  def initialize_project
    TakelageProject.instance.main = _project_read_main
    TakelageProject.instance.private = _project_read_private
    TakelageProject.instance.active = _project_merge_active
  end

  # @return [Object] global singleton project
  def project
    TakelageProject.instance
  end

  private

  # Read main YAML file.
  def _project_read_main
    path = TakelageProject.instance.config.active['project_root_dir']
    main_file = "#{path}/" \
        "#{TakelageProject.instance.config.active['info_project_main']}"

    return {} unless File.exist? main_file

    (read_yaml_erb_file(main_file) || {}).sort.to_h
  end

  # Read private YAML file.
  def _project_read_private
    path = TakelageProject.instance.config.active['project_root_dir']
    private_file = "#{path}/" \
        "#{TakelageProject.instance.config.active['info_project_private']}"

    return {} unless File.exist? private_file

    private_yaml = read_yaml_erb_file(private_file) || {}

    private_yaml.sort.to_h
  end

  # Merge active configuration.
  def _project_merge_active
    # make a clone or else we'll change the original hash
    main = TakelageProject.instance.main.clone
    private = TakelageProject.instance.private.clone

    # merge main and private to active
    # private wins against main
    main.merge!(private).sort.to_h
  end
end
