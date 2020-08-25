# frozen_string_literal: true

# takelage bit require export
module BitRequireExport
  # Backend method for bit require export.
  def bit_require_export
    log.debug 'Running bit require export'

    components = _bit_require_lib_get_components
    bitrequire_yml = _bit_require_export_get_bitrequire_yml components

    log.debug "bitrequire.yml of this project:\n#{bitrequire_yml}"
    bitrequire_yml
  end

  private

  # Create contents of bitrequire yaml file.
  # rubocop:disable Metrics/AbcSize
  def _bit_require_export_get_bitrequire_yml(components)
    bitrequire = {}
    components.each do |component|
      scope = component['id'].clone.gsub!(%r{/.*}, '')
      name = component['id'].clone.gsub!(%r{#{scope}/}, '')
      bitrequire['scopes'] = { scope => [] } if bitrequire['scopes'].nil?
      bitrequire['scopes'] = { scope => [] } unless bitrequire['scopes'].key? scope
      bitrequire['scopes'][scope] << { 'name' => name }
    end
    hash_to_yaml bitrequire
  end
  # rubocop:enable Metrics/AbcSize
end
