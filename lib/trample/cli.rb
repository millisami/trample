require 'thor'
if ENV['VERBOSE']
  require 'httplog'
  require 'pry'
  require 'pry-nav'
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

