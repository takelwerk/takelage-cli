# frozen_string_literal: true

# tau info status hg
module InfoStatusHg
  # Backend method for info status hg.
  # @return [Boolean] has mercurial been configured?
  def info_status_hg
    log.debug 'Check hg status'

    unless _info_status_hg_username
      log.error 'hg ui.username is not configured'
      return false
    end

    log.debug 'hg config is available'
    true
  end

  private

  # Check hg username
  def _info_status_hg_username
    status_username = try config.active['cmd_info_status_hg_username']
    status_username.exitstatus.zero?
  end
end
