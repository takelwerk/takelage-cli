# takelage project module
module ProjectModule
  # takelage config class.
  class TakelageProject
    include LoggingModule
    include SystemModule
    include ConfigModule

    attr_accessor :active, :private, :main

    def initialize
      @active = Hash.new
      @private = Hash.new
      @main = Hash.new
    end
  end

  # Global singleton config
  @@project = TakelageProject.new

  # Initialze project
  def initialize_project
    _rakefile, path = Rake.application.find_rakefile_location

    main_file = "#{path}/#{@@project.config.active['info_project_main']}"
    private_file = "#{path}/#{@@project.config.active['info_project_private']}"

    # read main project info
    if File.exist? main_file
      @@project.main = read_yaml_file(main_file) || {}
      @@project.main = @@project.main.sort.to_h
    end

    # read private project info
    if File.exist? private_file
      @@project.private = read_yaml_file(private_file) || {}
      @@project.private = @@project.private.sort.to_h
    end

    # make a clone or else we'll change the original hash
    main = @@project.main.clone
    private = @@project.private.clone

    # merge main and private to active
    # private wins against main
    @@project.active = main.merge!(private)
    @@project.active = @@project.active.sort.to_h
  end

  # @return [Object] global singleton project
  def project
    @@project
  end
end
