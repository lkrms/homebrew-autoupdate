# frozen_string_literal: true

module Autoupdate
  module Core
    module_function

    def base_name
      "com.github.domt4.homebrew-autoupdate"
    end

    def name
      # If already configured without an architecture-specific suffix, don't change anything
      if File.exist?(File.expand_path("~/Library/LaunchAgents/#{base_name}.plist")) ||
         File.exist?(File.expand_path("~/Library/Application Support/#{base_name}"))
        return base_name
      end

      "#{base_name}.#{Hardware::CPU.arch}"
    end

    def plist
      File.expand_path("~/Library/LaunchAgents/#{name}.plist")
    end

    def brew
      "/usr/bin/arch -#{Hardware::CPU.arch} #{HOMEBREW_PREFIX}/bin/brew"
    end

    def logs
      File.expand_path("~/Library/Logs/#{base_name}")
    end

    def fallback_logs
      File.expand_path("..", logs)
    end

    def location
      Pathname.new(File.expand_path("~/Library/Application Support/#{name}"))
    end

    def tap_dir
      origin = Tap.names.join(" ").match(%r{(\S+)/autoupdate})[1]
      Pathname.new(File.join(HOMEBREW_LIBRARY, "Taps", origin, "homebrew-autoupdate"))
    end
  end
end
