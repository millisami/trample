require 'thor'
if ENV['TEST']
  require 'httplog'
  require 'ruby-debug'
  ::Debugger.start
  ::Debugger.settings[:autoeval] = true if ::Debugger.respond_to?(:settings)
end

module Trample
  class Cli < Thor
    desc "start path/to/config/file", "Start trampling"
    def start(config)
      load(config)
      Runner.new(Trample.current_configuration).trample
    end
  end
end

