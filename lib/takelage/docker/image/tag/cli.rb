module Takelage

  # takelage docker image tag
  class DockerImageTag < SubCommandBase

    desc 'check [COMMAND]', 'Check docker image tag'
    subcommand 'check', DockerImageTagCheck

    desc 'latest [COMMAND]', 'Print latest local or remote docker image tag'
    subcommand 'latest', DockerImageTagLatest

    desc 'list [COMMAND]', 'Print local or remote docker image tags'
    subcommand 'list', DockerImageTagList

  end
end
