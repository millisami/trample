module Trample
  class Configuration
    attr_reader :pages

    def initialize(&block)
      @pages = []
      instance_eval(&block)
    end

    def concurrency(*value)
      @concurrency = value.first unless value.empty?
      @concurrency
    end

    def iterations(*value)
      @iterations = value.first unless value.empty?
      @iterations
    end

    def rampup_interval(*value)
      @rampup_interval = value.first unless value.empty?
      @rampup_interval
    end

    def random_wait_interval(*value)
      @random_wait_interval = value.first unless value.empty?
      @random_wait_interval
    end

    def client(*value)
      @client = value.first unless value.empty?
      @client
    end

    def get(url, &block)
      @pages << Page.new(:get, url, block || {})
    end

    def post(url, params = nil, &block)
      @pages << Page.new(:post, url, params || block)
    end

    def login
      if block_given?
        yield
        @login = pages.pop
      end

      @login
    end

    def ==(other)
      other.is_a?(Configuration) &&
        other.pages == pages &&
        other.concurrency == concurrency &&
        other.iterations  == iterations
    end
  end
end
