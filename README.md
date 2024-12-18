# takelage-cli

*takelage-cli* is a command line interface
to facilitate the takelage devops workflow.
The takelage devops workflow helps devops engineers
build, test and deploy os images.

The *takelage-cli* executable `tau` is a
[ruby](https://www.ruby-lang.org/)
command line script using the
[thor](http://whatisthor.com/) toolkit.

*takelage-cli* is also the remote control for the
[takelship](https://github.com/takelwerk/takelship).

The *takelage-cli* executable `ship` is a wrapper for `tau ship`.

## Framework Versions

| Project | Artifacts |
|-|-|
| [![takelage-doc](https://img.shields.io/badge/github-takelage--doc-purple)](https://github.com/takelwerk/takelage-doc) | [![License](https://img.shields.io/badge/license-GNU_GPLv3-blue)](https://github.com/takelwerk/takelage-doc/blob/main/LICENSE) |
| [![takelage-var](https://img.shields.io/badge/github-takelage--var-purple)](https://github.com/takelwerk/takelage-var) | [![pypi,org](https://img.shields.io/pypi/v/pytest-takeltest?label=pypi.org&color=blue)](https://pypi.org/project/pytest-takeltest/) |
| [![takelage-cli](https://img.shields.io/badge/github-takelage--cli-purple)](https://github.com/takelwerk/takelage-cli) | [![rubygems.org](https://img.shields.io/gem/v/takeltau?label=rubygems.org&color=blue)](https://rubygems.org/gems/takeltau) |
| [![takelage-img-takelslim](https://img.shields.io/badge/github-takelage--img--takelslim-purple)](https://github.com/takelwerk/takelage-img-takelslim) | [![hub.docker.com](https://img.shields.io/docker/v/takelwerk/takelslim/latest-amd64?label=hub.docker.com&arch=amd64&color=teal)](https://hub.docker.com/r/takelwerk/takelslim) [![hub.docker.com](https://img.shields.io/docker/v/takelwerk/takelslim/latest-arm64?label=hub.docker.com&arch=arm64&color=slateblue)](https://hub.docker.com/r/takelwerk/takelslim) | 
| [![takelage-img-takelbase](https://img.shields.io/badge/github-takelage--img--takelbase-purple)](https://github.com/takelwerk/takelage-img-takelbase) | [![hub.docker.com](https://img.shields.io/docker/v/takelwerk/takelbase/latest-amd64?label=hub.docker.com&arch=amd64&color=teal)](https://hub.docker.com/r/takelwerk/takelbase) [![hub.docker.com](https://img.shields.io/docker/v/takelwerk/takelbase/latest-arm64?label=hub.docker.com&arch=arm64&color=slateblue)](https://hub.docker.com/r/takelwerk/takelbase) |
| [![takelage-img-takelpodslim](https://img.shields.io/badge/github-takelage--img--takelpodslim-purple)](https://github.com/takelwerk/takelage-img-takelpodslim) | [![hub.docker.com](https://img.shields.io/docker/v/takelwerk/takelpodslim/latest-amd64?label=hub.docker.com&arch=amd64&color=teal)](https://hub.docker.com/r/takelwerk/takelpodslim) [![hub.docker.com](https://img.shields.io/docker/v/takelwerk/takelpodslim/latest-arm64?label=hub.docker.com&arch=arm64&color=slateblue)](https://hub.docker.com/r/takelwerk/takelpodslim) | 
| [![takelage-img-takelpodbase](https://img.shields.io/badge/github-takelage--img--takelpodbase-purple)](https://github.com/takelwerk/takelage-img-takelpodbase) | [![hub.docker.com](https://img.shields.io/docker/v/takelwerk/takelpodbase/latest-amd64?label=hub.docker.com&arch=amd64&color=teal)](https://hub.docker.com/r/takelwerk/takelpodbase) [![hub.docker.com](https://img.shields.io/docker/v/takelwerk/takelpodbase/latest-arm64?label=hub.docker.com&arch=arm64&color=slateblue)](https://hub.docker.com/r/takelwerk/takelpodbase) | 
| [![takelage-dev](https://img.shields.io/badge/github-takelage--dev-purple)](https://github.com/takelwerk/takelage-dev) | [![hub.docker.com](https://img.shields.io/docker/v/takelwerk/takelage/latest-amd64?label=hub.docker.com&arch=amd64&sort=semver&color=teal)](https://hub.docker.com/r/takelwerk/takelage) [![hub.docker.com](https://img.shields.io/docker/v/takelwerk/takelage/latest-arm64?label=hub.docker.com&arch=arm64&sort=semver&color=slateblue)](https://hub.docker.com/r/takelwerk/takelage) |
| [![takelage-pad](https://img.shields.io/badge/github-takelage--pad-purple)](https://github.com/takelwerk/takelage-pad) | [![hub.docker.com](https://img.shields.io/docker/v/takelwerk/takelpad/latest-amd64?label=hub.docker.com&arch=amd64&sort=semver&color=teal)](https://hub.docker.com/r/takelwerk/takelpad) [![hub.docker.com](https://img.shields.io/docker/v/takelwerk/takelpad/latest-arm64?label=hub.docker.com&arch=arm64&sort=semver&color=slateblue)](https://hub.docker.com/r/takelwerk/takelpad) |
| [![takelship](https://img.shields.io/badge/github-takelship-purple)](https://github.com/takelwerk/takelship) | [![hub.docker.com](https://img.shields.io/docker/v/takelwerk/takelship/latest-amd64?label=hub.docker.com&arch=amd64&sort=semver&color=teal)](https://hub.docker.com/r/takelwerk/takelship) [![hub.docker.com](https://img.shields.io/docker/v/takelwerk/takelship/latest-arm64?label=hub.docker.com&arch=arm64&sort=semver&color=slateblue)](https://hub.docker.com/r/takelwerk/takelship) | |


## Framework Status

| Project | Pipelines |
|-|-|
| [![takelage-var](https://img.shields.io/badge/github-takelage--var-purple)](https://github.com/takelwerk/takelage-var) | [![takeltest](https://img.shields.io/github/actions/workflow/status/takelwerk/takelage-var/takeltest.yml?label=takeltest)](https://github.com/takelwerk/takelage-var/actions/workflows/takeltest.yml) [![test_takeltest](https://img.shields.io/github/actions/workflow/status/takelwerk/takelage-var/test_takeltest.yml?label=test%20takeltest)](https://github.com/takelwerk/takelage-var/actions/workflows/test_takeltest.yml) |
| [![takelage-cli](https://img.shields.io/badge/github-takelage--cli-purple)](https://github.com/takelwerk/takelage-cli) | [![takeltau](https://img.shields.io/github/actions/workflow/status/takelwerk/takelage-cli/takeltau.yml?label=takeltau)](https://github.com/takelwerk/takelage-cli/actions/workflows/takeltau.yml) [![test_takeltau](https://img.shields.io/github/actions/workflow/status/takelwerk/takelage-cli/test_takeltau.yml?label=test%20takeltau)](https://github.com/takelwerk/takelage-cli/actions/workflows/test_takeltau.yml) |
| [![takelage-img-takelslim](https://img.shields.io/badge/github-takelage--img--takelslim-purple)](https://github.com/takelwerk/takelage-img-takelslim) | [![takelslim amd64](https://img.shields.io/github/actions/workflow/status/takelwerk/takelage-img-takelslim/takelslim_amd64.yml?label=takelslim%20amd64)](https://github.com/takelwerk/takelage-img-takelslim/actions/workflows/takelslim_amd64.yml) |
| [![takelage-img-takelbase](https://img.shields.io/badge/github-takelage--img--takelbase-purple)](https://github.com/takelwerk/takelage-img-takelbase) | [![takelbase amd64](https://img.shields.io/github/actions/workflow/status/takelwerk/takelage-img-takelbase/takelbase_amd64.yml?label=takelbase%20amd64)](https://github.com/takelwerk/takelage-img-takelbase/actions/workflows/takelbase_amd64.yml) | 
| [![takelage-img-takelpodslim](https://img.shields.io/badge/github-takelage--img--takelpodslim-purple)](https://github.com/takelwerk/takelage-img-takelpodslim) | [![takelpodslim amd64](https://img.shields.io/github/actions/workflow/status/takelwerk/takelage-img-takelpodslim/takelpodslim_amd64.yml?label=takelpodslim%20amd64)](https://github.com/takelwerk/takelage-img-takelpodslim/actions/workflows/takelpodslim_amd64.yml) |
| [![takelage-img-takelpodbase](https://img.shields.io/badge/github-takelage--img--takelpodbase-purple)](https://github.com/takelwerk/takelage-img-takelpodbase) | [![takelpodbase amd64](https://img.shields.io/github/actions/workflow/status/takelwerk/takelage-img-takelpodbase/takelpodbase_amd64.yml?label=takelpodbase%20amd64)](https://github.com/takelwerk/takelage-img-takelpodbase/actions/workflows/takelpodbase_amd64.yml) | 
| [![takelage-dev](https://img.shields.io/badge/github-takelage--dev-purple)](https://github.com/takelwerk/takelage-dev) | [![takelage amd64](https://img.shields.io/github/actions/workflow/status/takelwerk/takelage-dev/takelage_amd64.yml?label=takelage%20amd64)](https://github.com/takelwerk/takelage-dev/actions/workflows/takelage_amd64.yml) [![test_takelage](https://img.shields.io/github/actions/workflow/status/takelwerk/takelage-dev/test_takelage.yml?label=test%20takelage)](https://github.com/takelwerk/takelage-dev/actions/workflows/test_takelage.yml) 
| | [![takelbuild amd64](https://img.shields.io/github/actions/workflow/status/takelwerk/takelage-dev/takelbuild_amd64.yml?label=takelbuild%20amd64)](https://github.com/takelwerk/takelage-dev/actions/workflows/takelbuild_amd64.yml) [![test_takelbuild](https://img.shields.io/github/actions/workflow/status/takelwerk/takelage-dev/test_takelbuild.yml?label=test%20takelbuild)](https://github.com/takelwerk/takelage-dev/actions/workflows/test_takelbuild.yml) |
| | [![takelbeta amd64](https://img.shields.io/github/actions/workflow/status/takelwerk/takelage-dev/takelbeta_amd64.yml?label=takelbeta%20amd64)](https://github.com/takelwerk/takelage-dev/actions/workflows/takelbeta_amd64.yml) [![test_roles](https://img.shields.io/github/actions/workflow/status/takelwerk/takelage-dev/test_roles.yml?label=test%20roles)](https://github.com/takelwerk/takelage-dev/actions/workflows/test_roles.yml) |
| [![takelage-pad](https://img.shields.io/badge/github-takelage--pad-purple)](https://github.com/takelwerk/takelage-pad) | [![takelpad docker](https://img.shields.io/github/actions/workflow/status/takelwerk/takelage-pad/takelpad_docker.yml?label=takelpad%20docker)](https://github.com/takelwerk/takelage-pad/actions/workflows/takelpad_docker.yml) |
| | [![test takelpad](https://img.shields.io/github/actions/workflow/status/takelwerk/takelage-pad/test_takelpad.yml?label=test%20takelpad)](https://github.com/takelwerk/takelage-pad/actions/workflows/test_takelpad.yml) [![test roles](https://img.shields.io/github/actions/workflow/status/takelwerk/takelage-pad/test_roles.yml?label=test%20roles)](https://github.com/takelwerk/takelage-pad/actions/workflows/test_roles.yml) |
| [![takelship](https://img.shields.io/badge/github-takelship-purple)](https://github.com/takelwerk/takelship) | [![takelship docker](https://img.shields.io/github/actions/workflow/status/takelwerk/takelship/takelship-amd64.yml?label=takelship%20docker)](https://github.com/takelwerk/takelship/actions/workflows/takelship-amd64.yml) |

## Installation

*tau* is part of *takelage-dev*'s docker image
but you typically want to install it on the host system as well.
Install the takelage gem and its dependencies
through the [gem](https://github.com/rubygems/rubygems)
command line tool:

```bash
gem install takeltau
```

## Commands

*takelage-cli* uses [cucumber](https://github.com/cucumber/cucumber)
to system test its features.
You are encouraged to read the cucumber feature files
for the *tau* commands
to get an idea of how the commands work.
You can list the *tau* commands by running
*tau [self commands](features/cucumber/features/self/self.commands.feature)*
or *tau commands*:

| Command | Description |
| - |- |
| tau [completion bash](features/cucumber/features/completion/completion.bash.feature) | Print bash completion code |
| tau [docker check daemon](features/cucumber/features/docker/docker.check.daemon.feature) | Check if docker daemon is running |
| tau [docker container check existing](features/cucumber/features/docker/docker.container.check.existing.feature) [CONTAINER] | Check if docker [CONTAINER] is existing |
| tau [docker container check network](features/cucumber/features/docker/docker.container.check.network.feature) [NETWORK] | Check if docker [NETWORK] is existing |
| tau [docker container check orphaned](features/cucumber/features/docker/docker.container.check.orphaned.feature) [CONTAINER] | Check if docker [CONTAINER] is orphaned |
| tau [docker container clean](features/cucumber/features/docker/docker.container.clean.feature) | Remove all docker containers |
| tau [docker container command](features/cucumber/features/docker/docker.container.command.feature) [CMD] | Run [CMD] in a docker container |
| tau [docker container daemon](features/cucumber/features/docker/docker.container.daemon.feature) | Run docker container in daemon mode |
| tau [docker container list](features/cucumber/features/docker/docker.container.list.feature) | List docker containers |
| tau [docker container login](features/cucumber/features/docker/docker.container.login.feature) | Log in to latest local docker container |
| tau [docker container prune](features/cucumber/features/docker/docker.container.prune.feature) | Remove orphaned docker containers |
| tau [docker image tag check](features/cucumber/features/docker/docker.image.tag.check.feature) [TAG] | Check if local docker image [TAG] exists |
| tau [docker image tag latest](features/cucumber/features/docker/docker.image.tag.latest.feature) | Print latest local docker image tag |
| tau [docker image tag list](features/cucumber/features/docker/docker.image.tag.list.feature) | Print local docker image tags |
| tau [docker image update](features/cucumber/features/docker/docker.image.update.feature) | Get latest remote docker container |
| tau [git check clean](features/cucumber/features/git/git.check.clean.feature) | Check if the git workspace is clean |
| tau [git check hg](features/cucumber/features/git/git.check.hg.feature) | Check if we are on the git hg branch |
| tau [git check workspace](features/cucumber/features/git/git.check.workspace.feature) | Check if a git workspace exists |
| tau [hg list](features/cucumber/features/hg/hg.list.feature) | List hg repos |
| tau [hg pull](features/cucumber/features/hg/hg.pull.feature) | Pull hg repos |
| tau [hg push](features/cucumber/features/hg/hg.push.feature) | Push hg repos |
| tau [info project active](features/cucumber/features/info/info.project.active.feature) | Print active project info |
| tau [info project dir](features/cucumber/features/info/info.project.dir.feature) | Print project root directory |
| tau [info project main](features/cucumber/features/info/info.project.main.feature) | Print main project info |
| tau [info project private](features/cucumber/features/info/info.project.private.feature) | Print private project info |
| tau [info status bar](features/cucumber/features/info/info.status.bar.feature) | Print status bar |
| tau [info status arch](features/cucumber/features/info/info.status.arch.feature) | Check arch status |
| tau [info status git](features/cucumber/features/info/info.status.git.feature) | Check git status |
| tau [info status gopass](features/cucumber/features/info/info.status.gopass.feature) | Check gopass status |
| tau [info status gpg](features/cucumber/features/info/info.status.gpg.feature) | Check gpg status |
| tau [info status hg](features/cucumber/features/info/info.status.hg.feature) | Check hg status |
| tau [info status mutagen](features/cucumber/features/info/info.status.mutagen.feature) | Check mutagen status |
| tau [info status ssh](features/cucumber/features/info/info.status.ssh.feature) | Check ssh status |
| tau [init packer docker](features/cucumber/features/init/init.packer.docker.feature) | Initialize packer project for docker images |
| tau [init takelage rake](features/cucumber/features/init/init.takelage.rake.feature) | Initialize takelage rake project |
| tau [mutagen check daemon](features/cucumber/features/mutagen/mutagen.check.daemon.feature)) | Check if mutagen host conenction is available |
| tau [mutagen socket check](features/cucumber/features/mutagen/mutagen.socket.check.feature) [SOCKET] | Check if mutagen [SOCKET] exists |
| tau [mutagen socket create](features/cucumber/features/mutagen/mutagen.socket.create.feature) [NAME] [IN] [OUT] | Create a mutagen socket [NAME] from [IN] to [OUT] of the container |
| tau [mutagen socket list](features/cucumber/features/mutagen/mutagen.socket.list.feature) | List mutagen sockets |
| tau [mutagen socket terminate](features/cucumber/features/mutagen/mutagen.socket.terminate.feature) [SOCKET] | Terminate a mutagen [SOCKET] |
| tau [mutagen socket tidy](features/cucumber/features/mutagen/mutagen.socket.tidy.feature) | Remove mutagen daemon files |
| tau [self commands](features/cucumber/features/self/self.commands.feature) | List all commands |
| tau [self config active](features/cucumber/features/self/self.config.active.feature) | Print active takelage configuration |
| tau [self config default](features/cucumber/features/self/self.config.default.feature) | Print takelage default configuration |
| tau [self config home](features/cucumber/features/self/self.config.home.feature) | Print takelage home config file configuration |
| tau [self config project](features/cucumber/features/self/self.config.project.feature) | Print takelage project config file configuration |
| tau [self config envvars](features/cucumber/features/self/self.config.envvars.feature) | Print env vars takeltau configuration |
| tau [self version](features/cucumber/features/self/self.version.feature) | Print tau semantic version number |
| tau [ship completion bash](features/cucumber/features/ship/completion/completion.bash.feature) | Print bash completion code for ship subcommand |
| tau [ship container check existing](features/cucumber/features/ship/container/ship.container.check.existing.feature) | Check if a takelship is existing |
| tau [ship container clean](features/cucumber/features/ship/container/ship.container.clean.feature) | Stop all takelships |
| tau [ship container command](features/cucumber/features/ship/container/ship.container.command.feature) [CMD] | Run a bash command in a takelship container |
| tau [ship container list](features/cucumber/features/ship/container/ship.container.list.feature) | List takelships |
| tau [ship container hostname](features/cucumber/features/ship/container/ship.container.hostname.feature) | Print takelship hostname |
| tau [ship container login](features/cucumber/features/ship/container/ship.container.login.feature) | Log in to a takelship |
| tau [ship container logs](features/cucumber/features/ship/container/ship.container.logs.feature) [ARGS] | Print the takelship logs |
| tau [ship container name](features/cucumber/features/ship/container/ship.container.name.feature) | Print the takelship name |
| tau [ship container podman](features/cucumber/features/ship/container/ship.container.podman.feature) [CMD] | Run a podman command in a takelship |
| tau [ship container shipdir](features/cucumber/features/ship/container/ship.container.shipdir.feature) | Print takelship shipdir |
| tau [ship container stop](features/cucumber/features/ship/container/ship.container.stop.feature) | Stop a takelship |
| tau [ship container sudo](features/cucumber/features/ship/container/ship.container.sudo.feature) [CMD] | Run a sudo command in a takelship |
| tau [ship container update](features/cucumber/features/ship/container/ship.container.update.feature) | Update takelship image |
| tau [ship info takelconfig](features/cucumber/features/ship/info/ship.info.takelconfig.feature) | Print takelage config |
| tau [ship info takelship](features/cucumber/features/ship/info/ship.info.takelship.feature) | Print takelship info |
| tau [ship info version](features/cucumber/features/ship/info/ship.info.version.feature) | Print ship version |
| tau [ship project create](features/cucumber/features/ship/project/ship.project.create.feature) [PROJECT] | Create a takelship [PROJECT] |
| tau [ship project list](features/cucumber/features/ship/project/ship.project.list.feature) | List takelship projects |
| tau [ship project restart](features/cucumber/features/ship/project/ship.project.restart.feature) [PROJECT] | Restart a takelship [PROJECT] |
| tau [ship project start](features/cucumber/features/ship/project/ship.project.start.feature) [PROJECT] | Start a takelship [PROJECT] |
| tau [ship project stop](features/cucumber/features/ship/project/ship.project.stop.feature) | Stop a takelship project |
| tau [ship project update](features/cucumber/features/ship/project/ship.project.create.feature) [PROJECT] | Update a takelship [PROJECT] |
| tau ship board | Alias for tau [ship container login](features/cucumber/features/ship/container/ship.container.login.feature) |
| tau ship clean | Alias for tau [ship container clean](features/cucumber/features/ship/container/ship.container.clean.feature) |
| tau ship command [CMD] | Alias for tau [ship container command](features/cucumber/features/ship/container/ship.container.command.feature) |
| tau ship docker [CMD] | Alias for tau [ship container podman](features/cucumber/features/ship/container/ship.container.podman.feature) |
| tau ship list | Alias for tau [ship container list](features/cucumber/features/ship/container/ship.container.list.feature) |
| tau ship login | Alias for tau [ship container login](features/cucumber/features/ship/container/ship.container.login.feature) |
| tau ship logs [ARGS] | Alias for tau [ship container logs](features/cucumber/features/ship/container/ship.container.logs.feature) |
| tau ship ls | Alias for tau [ship container list](features/cucumber/features/ship/container/ship.container.list.feature) |
| tau ship name | Alias for tau [ship container list](features/cucumber/features/ship/container/ship.container.name.feature) |
| tau ship podman [CMD] | Alias for tau [ship container podman](features/cucumber/features/ship/container/ship.container.podman.feature) |
| tau ship sail [PROJECT] | Alias for tau [ship project start](features/cucumber/features/ship/project/ship.project.start.feature) |
| tau ship restart [PROJECT] | Alias for tau [ship project restart](features/cucumber/features/ship/project/ship.project.restart.feature) |
| tau ship start [PROJECT] | Alias for tau [ship project start](features/cucumber/features/ship/project/ship.project.start.feature) |
| tau ship stop | Alias for tau [ship project stop](features/cucumber/features/ship/project/ship.project.stop.feature) |
| tau ship sudo [CMD] | Alias for tau [ship container sudo](features/cucumber/features/ship/container/ship.container.sudo.feature) |
| tau ship wreck | Alias for tau [ship project stop](features/cucumber/features/ship/project/ship.project.stop.feature) |
| tau ship update | Alias for tau [ship container update](features/cucumber/features/ship/container/ship.container.update.feature) |
| tau ship version | Alias for tau [ship info version](features/cucumber/features/ship/container/ship.info.version.feature) |
| tau clean | Alias for tau [docker container clean](features/cucumber/features/docker/docker.container.clean.feature) |
| tau commands | Alias for tau [self commands](features/cucumber/features/self/self.commands.feature) |
| tau config | Alias for tau [self config active](features/cucumber/features/self/self.config.active.feature) |
| tau list | Alias for tau [docker container list](features/cucumber/features/docker/docker.container.list.feature) |
| tau ls | Alias for tau [docker container list](features/cucumber/features/docker/docker.container.list.feature) |
| tau login | Alias for tau [docker container login](features/cucumber/features/docker/docker.container.login.feature) |
| tau project | Alias for tau [info project active](features/cucumber/features/info/info.project.active.feature) |
| tau prune | Alias for tau [docker container prune](features/cucumber/features/docker/docker.container.prune.feature) |
| tau status | Alias for tau [docker info status bar](features/cucumber/features/info/info.status.bar.feature) |
| tau update | Alias for tau [docker image update](features/cucumber/features/docker/docker.image.update.feature) |
| tau version | Alias for tau [self version](features/cucumber/features/self/self.version.feature) |

**Warning: *tau update* will call *docker image prune* and remove all dangling images!**

## Configuration

### Configuration Files

*takelage-cli* uses three different YAML configuration files and environment variables which have different precedences.
They are merged to an active configuration during runtime
which can be inspected with
*tau [self config active](features/cucumber/features/self/self.config.active.feature)*
or *tau config*.

| Filename | Precedence | Description |
|-|-|-|
| *default.yml* | lowest | Shipped with *takelage-cli*. Sets defaults where applicable.|
| *~/.takelage.yml* | normal | User-wide configuration file in your home directory. This is your normal custom configuration file.|
| *takelage.yml* | highest | Project-specific configuration file next to your main Rakefile. Some projects need special configuration.|
| TAKELAGE_TAU_CONFIG_* | ultimate | Fileless configuration through TAKELAGE_TAU_CONFIG environment variables. |

The tau command line tool is directory-aware so it is important that you can set the working directory of the tau command.
The project directory is identified by precedence:

| Method | Precedence |
|-|-|
| Current working directory | lowest |
| Main [`Rakefile`](Rakefile) | normal |
| `TAKELAGE_WORKDIR` environment variable | highest |
| `--workdir`/`-w` command line option | ultimate |

### Configuration Examples

- You should add the following configuration items in your *~/.takelage.yml*
  if you want to use the *takelbeta* docker image channel:

```yaml
---
docker_repo: takelbeta
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

- You may prefer to interact with
  [mercurial](https://github.com/takelwerk/takelage-doc/blob/main/doc/tau/hg.md)
  through `tau hg`
  in a different branch than `main` in one project so you may add
  to your *takelage.yml*:


```yaml
---
git_hg_repo: my_git_hg_branch
```

Furthermore,
[every external command](https://github.com/takelwerk/takelage-cli/blob/main/lib/takeltau/default.yml)
can be reconfigured.

### Project Files

*tau* reads two different YAML project files
which have different precedences.
They are merged to an active configuration during runtime
which can be inspected with
*tau [info project active](features/cucumber/features/info/info.project.active.feature)*
or *tau project*.

| Default filename | Config key | Precedence | Description |
| -------- | ---------- | ---------- | ----------- |
| *project.yml* | info_project_main | normal | Main project file.|
| *private/project.yml* | info_project_private | highest | Private project file. Should be in *.gitignore*. |

### Bash Completion

Add this to your [bash startup files](https://www.gnu.org/software/bash/manual/html_node/Bash-Startup-Files.html):

```bash
source <(tau completion bash)
```

and/or

```bash
source <(ship completion bash)
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
