# frozen_string_literal: true

# tau info status bar
module InfoStatusBar
  # Backend method for info status bar.
  # @return [String] status info bar
  def info_status_bar
    log.debug 'Get status info bar'

    @bar_list = []
    @bar_status = true

    _info_status_bar_takelage
    _info_status_bar_tau
    _info_status_bar_arch
    _info_status_bar_git
    _info_status_bar_gopass
    _info_status_bar_gpg
    _info_status_bar_hg
    _info_status_bar_ssh
    _info_status_bar_mutagen

    say @bar_list.join(' | ')
    @bar_status
  end

  private

  # Add takelage version info to bar.
  def _info_status_bar_takelage
    # Check if we are inside a takelage docker container
    return unless _docker_container_lib_check_matrjoschka

    @bar_list << _info_status_lib_get_channel_and_version
  end

  # Add tau version info to bar.
  def _info_status_bar_tau
    @bar_list << "tau: #{Takeltau::VERSION.green}"
  end

  # Add architecture info to bar.
  def _info_status_bar_arch
    arch = info_status_arch
    if arch == false
      @status_arch = false
      architecture = 'unknown'.red
    else
      @status_arch = true
      architecture = arch.green
    end
    @bar_status &&= @status_arch
    @bar_list << "arch: #{architecture}"
  end

  # Add git status info to bar.
  def _info_status_bar_git
    @status_git = info_status_git
    @bar_status &&= @status_git
    @bar_list << ("git: #{@status_git ? 'ok'.green : 'no'.red}")
  end

  # Add gopass status info to bar.
  def _info_status_bar_gopass
    @status_gopass = info_status_gopass
    @bar_status &&= @status_gopass
    @bar_list << ("gopass: #{@status_gopass ? 'ok'.green : 'no'.red}")
  end

  # Add gpg status info to bar.
  def _info_status_bar_gpg
    if @status_git || @status_gopass
      @bar_list << "gpg: #{'ok'.green}"
      return
    end

    status_gpg = info_status_gpg
    @bar_status &&= status_gpg
    @bar_list << ("gpg: #{status_gpg ? 'ok'.green : 'no'.red}")
  end

  # Add git status info to bar.
  def _info_status_bar_hg
    @status_hg = info_status_hg
    @bar_status &&= @status_hg
    @bar_list << ("hg: #{@status_hg ? 'ok'.green : 'no'.red}")
  end

  # Add mutagen status info to bar.
  def _info_status_bar_mutagen
    status_mutagen = mutagen_check_daemon
    @bar_status &&= status_mutagen
    @bar_list << ("mutagen: #{status_mutagen ? 'ok'.green : 'no'.red}")
  end

  # Add ssh status info to bar.
  def _info_status_bar_ssh
    status_ssh = info_status_ssh
    @bar_status &&= status_ssh
    @bar_list << ("ssh: #{status_ssh ? 'ok'.green : 'no'.red}")
  end
end

# Amend String class with colorization.
class String
  # Colorize strings
  def colorize(color_code)
    "\e[#{color_code}m#{self}\e[0m"
  end

  # String color red
  def red
    colorize(31)
  end

  # String color green
  def green
    colorize(32)
  end

  # String color yellow
  def yellow
    colorize(33)
  end

  # String color blue
  def blue
    colorize(34)
  end

  # String color pink
  def pink
    colorize(35)
  end

  # String color light_blue
  def light_blue
    colorize(36)
  end
end
