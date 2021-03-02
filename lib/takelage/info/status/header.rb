# frozen_string_literal: true

# takelage info status header
module InfoStatusHeader
  # Backend method for info status header.
  # @return [String] status info header
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

  private

  def _info_status_header_takelage
    takelage_version_file = '/etc/takelage_version'
    if _file_exists? takelage_version_file
      _file_read takelage_version_file
      @header_list << "takelage: #{@content_file.chomp.green}"
    end
  end

  def _info_status_header_tau
    @header_list << "tau: #{Takelage::VERSION.green}"
  end

  def _info_status_header_git
    @status_git = info_status_git
    if @status_git
      @header_list << 'git: ' + 'ok'.green
    else
      @header_list << 'git: ' + 'no'.red
    end
  end

  def _info_status_header_gopass
    @status_gopass = info_status_gopass
    if @status_gopass
      @header_list << 'gopass: ' + 'ok'.green
    else
      @header_list << 'gopass: ' + 'no'.red
    end
  end

  def _info_status_header_gpg
    if @status_git || @status_gopass
      @header_list << 'gpg: ' + 'ok'.green
      return
    end

    if info_status_gpg
      @header_list << 'gpg: ' + 'ok'.green
    else
      @header_list << 'gpg: ' + 'no'.red
    end
  end

  def _info_status_header_ssh
    if info_status_ssh
      @header_list << 'ssh: ' + 'ok'.green
    else
      @header_list << 'ssh: ' + 'no'.red
    end
  end
end

class String
  def colorize(color_code)
    "\e[#{color_code}m#{self}\e[0m"
  end

  def red
    colorize(31)
  end

  def green
    colorize(32)
  end

  def yellow
    colorize(33)
  end

  def blue
    colorize(34)
  end

  def pink
    colorize(35)
  end

  def light_blue
    colorize(36)
  end
end
