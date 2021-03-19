# frozen_string_literal: true

module Takelage
  # takelage docker
  class Docker < SubCommandBase
    desc 'check [COMMAND]', 'Check docker'
    subcommand 'check', DockerCheck

    desc 'container [COMMAND]', 'Handle docker container'
    subcommand 'container', DockerContainer

    desc 'image [COMMAND]', 'Handle docker images'
    subcommand 'image', DockerImage
  end
end
