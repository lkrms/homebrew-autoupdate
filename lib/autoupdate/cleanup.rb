# frozen_string_literal: true

module Autoupdate
  module_function

  def cleanup
    logs = Autoupdate::Core.logs
    fallback_logs = Autoupdate::Core.fallback_logs
    base_name =Autoupdate::Core.base_name
    name = Autoupdate::Core.name

    # Remove log files created before an architecture-specific suffix was used
    log_files = Dir[File.join("{#{fallback_logs},#{logs}}", "{#{base_name},#{name}}.out")].uniq

    FileUtils.rm_f log_files
    FileUtils.rm_f Autoupdate::Core.plist
    FileUtils.rm_rf Autoupdate::Core.location
    # 'logs' may contain log files for another architecture, so only delete it if it's empty
    FileUtils.rmdir logs if File.exist?(logs) && Dir["#{logs}/*"].empty?
  end
end
