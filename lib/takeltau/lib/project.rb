# frozen_string_literal: true

# tau project module
module ProjectModule
  # tau project class.
  class TakeltauProject
    include Singleton
    include LoggingModule
    include SystemModule
    include ConfigModule

    attr_accessor :active, :private, :main, :dir

    def initialize
      @active = {}
      @private = {}
      @main = {}
      @dir = {}
    end
  end

  # Initialze project
  def initialize_project
    TakeltauProject.instance.main = _project_read_main
    TakeltauProject.instance.private = _project_read_private
    TakeltauProject.instance.active = _project_merge_active
    TakeltauProject.instance.dir =
      TakeltauProject.instance.config.active['project_root_dir']
  end

  # @return [Object] global singleton project
  def project
    TakeltauProject.instance
  end

  private

  # Read main YAML file.
  def _project_read_main
    dir = TakeltauProject.instance.config.active['project_root_dir']
    main_file = "#{dir}/" \
                "#{TakeltauProject.instance.config.active['info_project_main']}"

    return {} unless File.exist? main_file

    (read_yaml_erb_file(main_file) || {}).sort.to_h
  end

  # Read private YAML file.
  def _project_read_private
    dir = TakeltauProject.instance.config.active['project_root_dir']
    private_file = "#{dir}/" \
                   "#{TakeltauProject.instance.config.active['info_project_private']}"

    return {} unless File.exist? private_file

    private_yaml = read_yaml_erb_file(private_file) || {}

    private_yaml.sort.to_h
  end

  # Merge active configuration.
  def _project_merge_active
    # make a clone or else we'll change the original hash
    main = TakeltauProject.instance.main.clone
    private = TakeltauProject.instance.private.clone

    # merge main and private to active
    # private wins against main
    main.merge!(private).sort.to_h
  end
end
