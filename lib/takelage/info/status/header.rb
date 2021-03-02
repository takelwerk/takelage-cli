# frozen_string_literal: true

# takelage info status header
module InfoStatusHeader
  # Backend method for info status header.
  # @return [String] status info header
  # rubocop:disable Metrics/MethodLength
  def info_status_header
    log.debug 'Get status info header'

    @header_list = []

    _info_status_header_takelage
    _info_status_header_tau
    _info_status_header_git
    _info_status_header_gopass
    _info_status_header_gpg
    _info_status_header_ssh

    header = @header_list.join(' | ')
    log.debug "status info header: #{header}"
    header
  end
  # rubocop:enable Metrics/MethodLength

  private

  # Add takelage version info to header
  def _info_status_header_takelage
    takelage_version_file = '/etc/takelage_version'
    return unless _file_exists? takelage_version_file

    _file_read takelage_version_file
    @header_list << "takelage: #{@content_file.chomp.green}"
  end

  # Add tau version info to header
  def _info_status_header_tau
    @header_list << "tau: #{Takelage::VERSION.green}"
  end

  # Add git status info to header
  def _info_status_header_git
    @status_git = info_status_git
    @header_list << ("git: #{@status_git ? 'ok'.green : 'no'.red}")
  end

  # Add gopass status info to header
  def _info_status_header_gopass
    @status_gopass = info_status_gopass
    @header_list << ("gopass: #{@status_gopass ? 'ok'.green : 'no'.red}")
  end

  # Add gpg status info to header
  def _info_status_header_gpg
    if @status_git || @status_gopass
      @header_list << "gpg: #{'ok'.green}"
      return
    end

    @header_list << ("gpg: #{info_status_gpg ? 'ok'.green : 'no'.red}")
  end

  # Add ssh status info to header
  def _info_status_header_ssh
    @header_list << ("ssh: #{info_status_ssh ? 'ok'.green : 'no'.red}")
  end
end

# Amend String class with colorization
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
