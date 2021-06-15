# frozen_string_literal: true

# takelage info status bar
module InfoStatusBar
  # Backend method for info status bar.
  # @return [String] status info bar
  # rubocop:disable Metrics/MethodLength
  def info_status_bar
    log.debug 'Get status info bar'

    @bar_list = []

    _info_status_bar_takelage
    _info_status_bar_tau
    _info_status_bar_git
    _info_status_bar_gopass
    _info_status_bar_gpg
    _info_status_bar_mutagen
    _info_status_bar_ssh

    bar = @bar_list.join(' | ')
    log.debug "status info bar: #{bar}"
    bar
  end
  # rubocop:enable Metrics/MethodLength

  private

  # Add takelage version info to bar.
  def _info_status_bar_takelage
    takelage_version_file = '/etc/takelage_version'
    return unless _file_exists? takelage_version_file

    _file_read takelage_version_file
    @bar_list << "#{config.active['docker_repo']}: #{@content_file.chomp.green}"
  end

  # Add tau version info to bar.
  def _info_status_bar_tau
    @bar_list << "tau: #{Takelage::VERSION.green}"
  end

  # Add git status info to bar.
  def _info_status_bar_git
    @status_git = info_status_git
    @bar_list << ("git: #{@status_git ? 'ok'.green : 'no'.red}")
  end

  # Add gopass status info to bar.
  def _info_status_bar_gopass
    @status_gopass = info_status_gopass
    @bar_list << ("gopass: #{@status_gopass ? 'ok'.green : 'no'.red}")
  end

  # Add gpg status info to bar.
  def _info_status_bar_gpg
    if @status_git || @status_gopass
      @bar_list << "gpg: #{'ok'.green}"
      return
    end

    @bar_list << ("gpg: #{info_status_gpg ? 'ok'.green : 'no'.red}")
  end

  # Add mutagen status info to bar.
  def _info_status_bar_mutagen
    @bar_list << ("mutagen: #{mutagen_check_daemon ? 'ok'.green : 'no'.red}")
  end

  # Add ssh status info to bar.
  def _info_status_bar_ssh
    @bar_list << ("ssh: #{info_status_ssh ? 'ok'.green : 'no'.red}")
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
