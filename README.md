# takelage-cli

*takelage-cli* is a command line interface 
to facilitate the takelage devops workflow.
The takelage devops workflow helps devops engineers
build, test and deploy os images.

The *takelage-cli* executable *tau* is a 
[ruby](https://www.ruby-lang.org/) 
command line script using the 
[thor](http://whatisthor.com/) toolkit.

## Framework

The takelage devops framework consists of these projects:

| App | Description |
| --- | ----------- |
| *[takelage-dev](https://github.com/geospin-takelage/takelage-dev)* | takelage development environment |
| *[takelage-var](https://github.com/geospin-takelage/takelage-var)* | takelage test plugin |
| *[takelage-cli](https://github.com/geospin-takelage/takelage-cli)* | takelage command line interface |
| *[takelage-bit](https://github.com/geospin-takelage/takelage-bit)* | takelage bit server | 

## Installation

*tau* is part of *takelage-dev*'s docker image 
but you typically want to install it on the host system as well.
Install the takelage gem and its dependencies 
through the [gem](https://github.com/rubygems/rubygems)
command line tool:

```bash
gem install takelage thor fylla logger json
```

## Commands

*takelage-cli* uses [cucumber](https://github.com/cucumber/cucumber)
to system test its features.
You are encouraged to read the cucumber feature files
for the *tau* commands
to get an idea of how the commands work.
You can list the *tau* commands by running
*tau [self list](features/takelage/self/self.list.feature)*
or *tau list*:

Command	| Description
------- | -----------
tau [bit check workspace](features/takelage/bit/bit.check.workspace.feature) | Check if a bit workspace exists
tau [bit clipboard copy](features/takelage/bit/bit.clipboard.copy.feature) [DIR] [SCOPE] | Copy new [DIR] to [SCOPE]
tau [bit clipboard paste](features/takelage/bit/bit.clipboard.paste.feature) [COMPONENT] [DIR] | Paste bit [COMPONENT] into [DIR]
tau [bit clipboard pull](features/takelage/bit/bit.clipboard.pull.feature) | Pull all updates for bit components from bit remote scopes
tau [bit clipboard push](features/takelage/bit/bit.clipboard.push.feature) | Push all updates of bit components to bit remote scopes
tau [bit scope add](features/takelage/bit/bit.scope.add.feature) [SCOPE] | Add a bit [SCOPE]
tau [bit scope list](features/takelage/bit/bit.scope.list.feature) | List bit remote scopes
tau [bit scope new](features/takelage/bit/bit.scope.new.feature) [SCOPE] | Init a new bit [SCOPE]
tau [completion bash](features/takelage/completion/completion.bash.feature) | Print bash completion code
tau [docker container check existing](features/takelage/docker/docker.container.check.existing.feature) [CONTAINER] | Check if docker [CONTAINER] is existing
tau [docker container check orphaned](features/takelage/docker/docker.container.check.orphaned.feature) [CONTAINER] | Check if docker [CONTAINER] is orphaned
tau [docker container check network](features/takelage/docker/docker.container.check.network.feature) [NETWORK] | Check if docker [NETWORK] is existing
tau [docker container command](features/takelage/docker/docker.container.command.feature) [CMD] | Run [CMD] in a docker container
tau [docker container daemon](features/takelage/docker/docker.container.daemon.feature) | Run docker container in daemon mode
tau [docker container login](features/takelage/docker/docker.container.login.feature) | Log in to latest local docker container
tau [docker container nuke](features/takelage/docker/docker.container.nuke.feature) | Remove all docker containers
tau [docker container purge](features/takelage/docker/docker.container.purge.feature) | Remove orphaned docker containers
tau [docker image tag check local](features/takelage/docker/docker.image.tag.check.local.feature) [TAG] | Check if local docker image [TAG] exists
tau [docker image tag check remote](features/takelage/docker/docker.image.tag.check.remote.feature) [TAG] | Check if remote docker image [TAG] exists
tau [docker image tag latest local](features/takelage/docker/docker.image.tag.latest.local.feature) | Print latest local docker image tag
tau [docker image tag latest remote](features/takelage/docker/docker.image.tag.latest.remote.feature) | Print latest remote docker image tag
tau [docker image tag list local](features/takelage/docker/docker.image.tag.list.local.feature) | Print local docker image tags
tau [docker image tag list remote](features/takelage/docker/docker.image.tag.list.remote.feature) | Print remote docker image tags
tau [docker image update](features/takelage/docker/docker.image.update.feature) | Get latest remote docker container
tau [docker socket start](features/takelage/docker/docker.socket.start.feature) | Start sockets for docker container
tau [docker socket stop](features/takelage/docker/docker.socket.stop.feature) | Stop sockets for docker container
tau [git check clean](features/takelage/git/git.check.clean.feature) | Check if the git workspace is clean
tau [git check master](features/takelage/git/git.check.master.feature) | Check if we are on the git master branch
tau [git check workspace](features/takelage/git/git.check.workspace.feature) | Check if a git workspace exists
tau [info project active](features/takelage/info/info.project.active.feature) | Print active project info
tau [info project private](features/takelage/info/info.project.private.feature) | Print private project info
tau [info project main](features/takelage/info/info.project.main.feature) | Print main project info
tau [self config active](features/takelage/self/self.config.active.feature) | Print active takelage configuration
tau [self config default](features/takelage/self/self.config.default.feature) | Print takelage default configuration
tau [self config home](features/takelage/self/self.config.home.feature) | Print takelage home config file configuration
tau [self config project](features/takelage/self/self.config.project.feature) | Print takelage project config file configuration
tau [self list](features/takelage/self/self.list.feature) | List all commands
tau [self version](features/takelage/self/self.version.feature) | Print tau semantic version number
tau config | Alias for tau [self config active](features/takelage/self/self.config.active.feature)
tau copy [DIR] [SCOPE] | Alias for tau [bit clipboard copy](features/takelage/bit/bit.clipboard.copy.feature)
tau list | Alias for tau [self list](features/takelage/self/self.list.feature)
tau login | Alias for tau [docker container login](features/takelage/docker/docker.container.login.feature)
tau nuke | Alias for tau [docker container nuke](features/takelage/docker/docker.container.nuke.feature)
tau paste [COMPONENT] [DIR] | Alias for tau [bit clipboard paste](features/takelage/bit/bit.clipboard.paste.feature)
tau project | Alias for tau [info project active](features/takelage/info/info.project.active.feature)
tau pull | Alias for tau [bit clipboard pull](features/takelage/bit/bit.clipboard.pull.feature)
tau purge | Alias for tau [docker container purge](features/takelage/docker/docker.container.purge.feature)
tau push | Alias for tau [bit clipboard push](features/takelage/bit/bit.clipboard.push.feature)
tau update | Alias for tau [docker image update](features/takelage/docker/docker.image.update.feature)
tau version | Alias for tau [self version](features/takelage/self/self.version.feature)

## Configuration

### Configuration Files

*takelage-cli* uses three different YAML configuration files
which have different precedences.
They are merged to an active configuration during runtime
which can be inspected with 
*tau [self config active](features/takelage/self/self.config.active.feature)*
or *tau config*.

| Filename | Precedence | Description |
| -------- | ---------- | ----------- |
| *default.yml* | lowest | Shipped with *takelage-cli*. Sets defaults where applicable. |
| *~/.takelage.yml* | normal | User-wide configuration file in your home directory. This is your normal custom configuration file. |
| *takelage.yml* | highest | Project-specific configuration file next to your main Rakefile. Some projects need special configuration. |

### Configuration Examples
 
- You should the following configuration items in your *~/.takelage.yml*
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
docker_image: takelage-mock
```

### Project Files

*tau* reads two different YAML project files
which have different precedences.
They are merged to an active configuration during runtime
which can be inspected with 
*tau [info project active](features/takelage/info/info.project.active.feature)*
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

*takelage-cli* ships with 
[cucumber](https://github.com/cucumber/cucumber) ruby tests.
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
