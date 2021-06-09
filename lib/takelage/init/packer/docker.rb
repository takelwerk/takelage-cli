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

    initialize_config

    exit_code &&= bit_require_import

    exit_code
  end

  private

  def _init_packer_docker_files_get
    ansiblelint = {
      name: '.ansible-lint',
      template: 'templates/ansiblelint.tt' }
    bitrequireyml = {
      name: 'bitrequire.yml',
      template: 'templates/bitrequireyml.tt' }
    gitignore = {
      name: '.gitgnore',
      template: 'templates/gitignore.tt' }
    groupvarsprojectyml = {
      name: 'ansible/group_vars/project.yml',
      template: 'templates/groupvarsprojectyml.tt' }
    playbooksiteyml = {
      name: 'ansible/playbook-site.yml',
      template: 'templates/playbooksiteyml.tt' }
    projectyml = {
      name: 'project.yml',
      template: 'templates/projectyml.tt' }
    rakefile = {
      name: 'Rakefile',
      template: 'templates/Rakefile.tt' }

    [
      ansiblelint,
      bitrequireyml,
      gitignore,
      groupvarsprojectyml,
      playbooksiteyml,
      projectyml,
      rakefile
    ]
  end
end
