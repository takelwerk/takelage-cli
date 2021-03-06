[![takelage image](https://github.com/geospin-takelage/takelage-cli/actions/workflows/test_project_nightly.yml/badge.svg)](https://github.com/geospin-takelage/takelage-cli/actions/workflows/test_project_nightly.yml)
[![rubygems.org](https://img.shields.io/gem/v/takelage?label=rubygems.org&color=blue)](https://rubygems.org/gems/takelage)
[![License](https://img.shields.io/github/license/geospin-takelage/takelage-cli?label=License&color=blueviolet)](https://github.com/geospin-takelage/takelage-cli/blob/main/LICENSE)

# takelage-cli

*takelage-cli* is a command line interface 
to facilitate the takelage devops workflow.
The takelage devops workflow helps devops engineers
build, test and deploy os images.

The *takelage-cli* executable *tau* is a 
[ruby](https://www.ruby-lang.org/) 
command line script using the 
[thor](http://whatisthor.com/) toolkit.

## Framework Versions

| App | Artifact |
| --- | -------- |
| *[takelage-doc](https://github.com/geospin-takelage/takelage-doc)* | [![License](https://img.shields.io/github/license/geospin-takelage/takelage-doc?label=License&color=blueviolet)](https://github.com/geospin-takelage/takelage-doc/blob/main/LICENSE) |
| *[takelage-dev](https://github.com/geospin-takelage/takelage-dev)* | [![hub.docker.com](https://img.shields.io/docker/v/takelage/takelage/latest?label=hub.docker.com&sort=semver&color=blue)](https://hub.docker.com/r/takelage/takelage) |
| *[takelage-cli](https://github.com/geospin-takelage/takelage-cli)* | [![rubygems.org](https://img.shields.io/gem/v/takelage?label=rubygems.org&color=blue)](https://rubygems.org/gems/takelage) |
| *[takelage-var](https://github.com/geospin-takelage/takelage-var)* | [![pypi,org](https://img.shields.io/pypi/v/takeltest?label=pypi.org&color=blue)](https://pypi.org/project/takeltest/) |
| *[takelage-bit](https://github.com/geospin-takelage/takelage-bit)* | [![hub.docker.com](https://img.shields.io/docker/v/takelage/bitboard/latest?label=hub.docker.com&sort=semver&color=blue)](https://hub.docker.com/r/takelage/bitboard) | 
| *[takelage-img-takelslim](https://github.com/geospin-takelage/takelage-img-takelslim)* | [![hub.docker.com](https://img.shields.io/docker/v/takelage/takelslim/latest?label=hub.docker.com&color=blue)](https://hub.docker.com/r/takelage/takelslim) | 
| *[takelage-img-takelbase](https://github.com/geospin-takelage/takelage-img-takelbase)* | [![hub.docker.com](https://img.shields.io/docker/v/takelage/takelbase/latest?label=hub.docker.com&color=blue)](https://hub.docker.com/r/takelage/takelbase) | 
| *[takelage-img-multipostgres](https://github.com/geospin-takelage/takelage-img-multipostgres)* | [![hub.docker.com](https://img.shields.io/docker/v/takelage/multipostgres/latest?label=hub.docker.com&color=blue)](https://hub.docker.com/r/takelage/multipostgres) | 

## Framework Status

| App | Deploy project | Test project | Test roles |
| --- | -------------- | ------------ | ---------- |
| *[takelage-dev](https://github.com/geospin-takelage/takelage-dev)* | [![deploy project](https://img.shields.io/github/workflow/status/geospin-takelage/takelage-dev/Build,%20test%20and%20deploy%20project?label=deploy%20project)](https://github.com/geospin-takelage/takelage-dev/actions/workflows/build_test_deploy_project_on_push.yml) | [![test project](https://img.shields.io/github/workflow/status/geospin-takelage/takelage-dev/Build%20and%20test%20project?label=test%20project)](https://github.com/geospin-takelage/takelage-dev/actions/workflows/build_test_project_nightly.yml) | [![test roles](https://img.shields.io/github/workflow/status/geospin-takelage/takelage-dev/Test%20roles?label=test%20roles)](https://github.com/geospin-takelage/takelage-dev/actions/workflows/build_test_roles_nightly.yml) |
| *[takelage-cli](https://github.com/geospin-takelage/takelage-cli)* | [![deploy project](https://img.shields.io/github/workflow/status/geospin-takelage/takelage-cli/Build,%20test%20and%20deploy%20project?label=deploy%20project)](https://github.com/geospin-takelage/takelage-cli/actions/workflows/build_test_deploy_project_on_push.yml) | [![test project](https://img.shields.io/github/workflow/status/geospin-takelage/takelage-cli/Test%20project?label=test%20project)](https://github.com/geospin-takelage/takelage-cli/actions/workflows/test_project_nightly.yml) |
| *[takelage-var](https://github.com/geospin-takelage/takelage-var)* |[![deploy project](https://img.shields.io/github/workflow/status/geospin-takelage/takelage-var/Build,%20test%20and%20deploy%20project?label=deploy%20project)](https://github.com/geospin-takelage/takelage-var/actions/workflows/build_test_deploy_project_on_push.yml) | [![test project](https://img.shields.io/github/workflow/status/geospin-takelage/takelage-var/Build%20and%20test%20project?label=test%20project)](https://github.com/geospin-takelage/takelage-var/actions/workflows/build_test_project_nightly.yml) |
| *[takelage-bit](https://github.com/geospin-takelage/takelage-bit)* | [![deploy project](https://img.shields.io/github/workflow/status/geospin-takelage/takelage-bit/Build,%20test%20and%20deploy%20project?label=deploy%20project)](https://github.com/geospin-takelage/takelage-bit/actions/workflows/build_test_deploy_project_on_push.yml) | [![test project](https://img.shields.io/github/workflow/status/geospin-takelage/takelage-bit/Build%20and%20test%20project?label=test%20project)](https://github.com/geospin-takelage/takelage-bit/actions/workflows/build_test_project_nightly.yml) | [![test roles](https://img.shields.io/github/workflow/status/geospin-takelage/takelage-bit/Test%20roles?label=test%20roles)](https://github.com/geospin-takelage/takelage-bit/actions/workflows/build_test_roles_nightly.yml) |
| *[takelage-img-takelslim](https://github.com/geospin-takelage/takelage-img-takelslim)* | [![deploy project](https://img.shields.io/github/workflow/status/geospin-takelage/takelage-img-takelslim/Build%20and%20deploy%20takelslim?label=deploy%20project)](https://github.com/geospin-takelage/takelage-img-takelslim/actions/workflows/build_deploy_takelslim_nightly.yml) |
| *[takelage-img-takelbase](https://github.com/geospin-takelage/takelage-img-takelbase)* | [![deploy project](https://img.shields.io/github/workflow/status/geospin-takelage/takelage-img-takelbase/Build%20and%20deploy%20takelbase?label=deploy%20project)](https://github.com/geospin-takelage/takelage-img-takelbase/actions/workflows/build_deploy_takelbase_nightly.yml) |
| *[takelage-img-multipostgres](https://github.com/geospin-takelage/takelage-img-multipostgres)* | [![deploy project](https://img.shields.io/github/workflow/status/geospin-takelage/takelage-img-multipostgres/Build%20and%20deploy%20multipostgres?label=deploy%20project)](https://github.com/geospin-takelage/takelage-img-multipostgres/actions/workflows/build_deploy_multipostgres_nightly.yml) |

## Installation

*tau* is part of *takelage-dev*'s docker image 
but you typically want to install it on the host system as well.
Install the takelage gem and its dependencies 
through the [gem](https://github.com/rubygems/rubygems)
command line tool:

```bash
gem install takelage
```

## Commands

*takelage-cli* uses [cucumber](https://github.com/cucumber/cucumber)
to system test its features.
You are encouraged to read the cucumber feature files
for the *tau* commands
to get an idea of how the commands work.
You can list the *tau* commands by running
*tau [self list](features/cucumber/features/self/self.list.feature)*
or *tau list*:

Command	| Description
------- | -----------
tau [bit check workspace](features/cucumber/features/bit/bit.check.workspace.feature) | Check if a bit workspace exists
tau [bit clipboard copy](features/cucumber/features/bit/bit.clipboard.copy.feature) [DIR] [SCOPE] | Copy new [DIR] to [SCOPE]
tau [bit clipboard paste](features/cucumber/features/bit/bit.clipboard.paste.feature) [COMPONENT] [DIR] | Paste bit [COMPONENT] into [DIR]
tau [bit clipboard pull](features/cucumber/features/bit/bit.clipboard.pull.feature) | Pull all updates for bit components from bit remote scopes
tau [bit clipboard push](features/cucumber/features/bit/bit.clipboard.push.feature) | Push all updates of bit components to bit remote scopes
tau [bit require export](features/cucumber/features/bit/bit.require.export.feature) | Show requirements file of bit components
tau [bit require import](features/cucumber/features/bit/bit.require.import.feature) | Import bit components from requirements file
tau [bit scope add](features/cucumber/features/bit/bit.scope.add.feature) [SCOPE] | Add a bit [SCOPE]
tau [bit scope inbit](features/cucumber/features/bit/bit.scope.inbit.feature) | Log in to bit remote server
tau [bit scope list](features/cucumber/features/bit/bit.scope.list.feature) | List bit remote scopes
tau [bit scope new](features/cucumber/features/bit/bit.scope.new.feature) [SCOPE] | Init a new bit [SCOPE]
tau [completion bash](features/cucumber/features/completion/completion.bash.feature) | Print bash completion code
tau [docker check daemon](features/cucumber/features/docker/docker.check.daemon.feature) | Check if docker daemon is running
tau [docker check socat](features/cucumber/features/docker/docker.check.socat.feature) | Check if socat command is available
tau [docker container check existing](features/cucumber/features/docker/docker.container.check.existing.feature) [CONTAINER] | Check if docker [CONTAINER] is existing
tau [docker container check network](features/cucumber/features/docker/docker.container.check.network.feature) [NETWORK] | Check if docker [NETWORK] is existing
tau [docker container check orphaned](features/cucumber/features/docker/docker.container.check.orphaned.feature) [CONTAINER] | Check if docker [CONTAINER] is orphaned
tau [docker container clean](features/cucumber/features/docker/docker.container.clean.feature) | Remove all docker containers
tau [docker container command](features/cucumber/features/docker/docker.container.command.feature) [CMD] | Run [CMD] in a docker container
tau [docker container daemon](features/cucumber/features/docker/docker.container.daemon.feature) | Run docker container in daemon mode
tau [docker container login](features/cucumber/features/docker/docker.container.login.feature) | Log in to latest local docker container
tau [docker container prune](features/cucumber/features/docker/docker.container.prune.feature) | Remove orphaned docker containers
tau [docker image tag check](features/cucumber/features/docker/docker.image.tag.check.feature) [TAG] | Check if local docker image [TAG] exists
tau [docker image tag latest](features/cucumber/features/docker/docker.image.tag.latest.feature) | Print latest local docker image tag
tau [docker image tag list](features/cucumber/features/docker/docker.image.tag.list.feature) | Print local docker image tags
tau [docker image update](features/cucumber/features/docker/docker.image.update.feature) | Get latest remote docker container
tau [docker socket host](features/cucumber/features/docker/docker.socket.host.feature) | Print docker socket host ip address
tau [docker socket scheme](features/cucumber/features/docker/docker.socket.scheme.feature) | Print docker socket scheme
tau [docker socket start](features/cucumber/features/docker/docker.socket.start.feature) | Start sockets for docker container
tau [docker socket stop](features/cucumber/features/docker/docker.socket.stop.feature) | Stop sockets for docker container
tau [git check clean](features/cucumber/features/git/git.check.clean.feature) | Check if the git workspace is clean
tau [git check main](features/cucumber/features/git/git.check.main.feature) | Check if we are on the git main branch
tau [git check workspace](features/cucumber/features/git/git.check.workspace.feature) | Check if a git workspace exists
tau [info project active](features/cucumber/features/info/info.project.active.feature) | Print active project info
tau [info project dir](features/cucumber/features/info/info.project.dir.feature) | Print project root directory
tau [info project main](features/cucumber/features/info/info.project.main.feature) | Print main project info
tau [info project private](features/cucumber/features/info/info.project.private.feature) | Print private project info
tau [info status git](features/cucumber/features/info/info.status.git.feature) | Check git status info
tau [info status gopass](features/cucumber/features/info/info.status.gopass.feature) | Check gopass status info
tau [info status gpg](features/cucumber/features/info/info.status.gpg.feature) | Check gpg status info
tau [info status header](features/cucumber/features/info/info.status.header.feature) | Print status info header
tau [info status ssh](features/cucumber/features/info/info.status.ssh.feature) | Check ssh status info
tau [self config active](features/cucumber/features/self/self.config.active.feature) | Print active takelage configuration
tau [self config default](features/cucumber/features/self/self.config.default.feature) | Print takelage default configuration
tau [self config home](features/cucumber/features/self/self.config.home.feature) | Print takelage home config file configuration
tau [self config project](features/cucumber/features/self/self.config.project.feature) | Print takelage project config file configuration
tau [self list](features/cucumber/features/self/self.list.feature) | List all commands
tau [self version](features/cucumber/features/self/self.version.feature) | Print tau semantic version number
tau clean | Alias for tau [docker container clean](features/cucumber/features/docker/docker.container.clean.feature)
tau config | Alias for tau [self config active](features/cucumber/features/self/self.config.active.feature)
tau copy [DIR] [SCOPE] | Alias for tau [bit clipboard copy](features/cucumber/features/bit/bit.clipboard.copy.feature)
tau list | Alias for tau [self list](features/cucumber/features/self/self.list.feature)
tau login | Alias for tau [docker container login](features/cucumber/features/docker/docker.container.login.feature)
tau paste [COMPONENT] [DIR] | Alias for tau [bit clipboard paste](features/cucumber/features/bit/bit.clipboard.paste.feature)
tau project | Alias for tau [info project active](features/cucumber/features/info/info.project.active.feature)
tau prune | Alias for tau [docker container prune](features/cucumber/features/docker/docker.container.prune.feature)
tau pull | Alias for tau [bit clipboard pull](features/cucumber/features/bit/bit.clipboard.pull.feature)
tau push | Alias for tau [bit clipboard push](features/cucumber/features/bit/bit.clipboard.push.feature)
tau status | Alias for tau [docker info status header](features/cucumber/features/info/info.status.header.feature)
tau update | Alias for tau [docker image update](features/cucumber/features/docker/docker.image.update.feature)
tau version | Alias for tau [self version](features/cucumber/features/self/self.version.feature)

**Warning: *tau update* will call *docker image prune* and remove all dangling images!**

## Configuration

### Configuration Files

*takelage-cli* uses three different YAML configuration files
which have different precedences.
They are merged to an active configuration during runtime
which can be inspected with 
*tau [self config active](features/cucumber/features/self/self.config.active.feature)*
or *tau config*.

| Filename | Precedence | Description |
| -------- | ---------- | ----------- |
| *default.yml* | lowest | Shipped with *takelage-cli*. Sets defaults where applicable. |
| *~/.takelage.yml* | normal | User-wide configuration file in your home directory. This is your normal custom configuration file. |
| *takelage.yml* | highest | Project-specific configuration file next to your main Rakefile. Some projects need special configuration. |

Please remember that a project directory is identified by the main
[Rakefile](Rakefile).

### Configuration Examples

- You should add the following configuration items in your *~/.takelage.yml*
if you want to use a private bit remote server:

```yaml
---
bit_remote: 'ssh://bit@bit.example.com:222:/bit'
bit_ssh: 'ssh -p 222 bit@bit.example.com'
```

- If you want to pin a specific docker tag for one of your projects
then create an *takelage.yml* file with:

```yaml
---
docker_tag: '1.2.3'
```

- The cucumber tests make use of an *~/.takelage.yml*
to overwrite defaults like:

```yaml
---
docker_repo: takelage-mock
```

Furthermore, every external command can be reconfigured.

### Project Files

*tau* reads two different YAML project files
which have different precedences.
They are merged to an active configuration during runtime
which can be inspected with 
*tau [info project active](features/cucumber/features/info/info.project.active.feature)*
or *tau project*.

| Default filename | Config key | Precedence | Description |
| -------- | ---------- | ---------- | ----------- |
| *project.yml* | info_project_main | normal | Main project file.  |
| *private/project.yml* | info_project_private | highest | Private project file. Should be in *.gitignore*. |

### Bash Completion

Add this to your [bash startup files](https://www.gnu.org/software/bash/manual/html_node/Bash-Startup-Files.html):

```bash
source <(tau completion bash)
```

### Software Tests

*takelage-cli* uses
[minitest](https://github.com/seattlerb/minitest) unit tests.

*takelage-cli* ships with 
[cucumber](https://github.com/cucumber/cucumber) ruby system tests.
It uses cucumber's 
[aruba](https://github.com/cucumber/aruba) extension and especially its
[filesystem](https://relishapp.com/cucumber/aruba/v/0-11-0/docs/filesystem)
library.

*takelage-cli* [deploys](https://docs.docker.com/registry/deploying/)
a private docker 
[registry](https://hub.docker.com/_/registry)
to conduct end-to-end tests of *tau docker* commands.
The registry exposes port 5005. 
You need to whitelist it in your host's docker engine configuration: 

```json
{
  "insecure-registries": [
    "host.docker.internal:5005"
  ]
}
```

*takelage-cli* deploys a 
*[bitboard](https://hub.docker.com/r/takelage/bitboard)*
server created with 
*[takelage-bit](https://github.com/geospin-takelage/takelage-bit)*
to end-to-end test the *tau bit* commands.
