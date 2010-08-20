module Trample
  class Session
    include Logging
    include Timer

    attr_reader :config, :response_times, :cookies, :last_response

    def initialize(config)
      @config         = config
      @response_times = []
      @cookies        = {}
    end

    def trample
      hit @config.login unless @config.login.nil?
      @config.iterations.times do
        @config.pages.each do |p|
          sleep(sleep_interval)
          hit p
        end
      end
      response_times
    end

    protected
      def hit(page)
        response_times << request(page)
        # this is ugly, but it's the only way that I could get the test to pass
        # because rr keeps a reference to the arguments, not a copy. ah well.
        @cookies = cookies.merge(last_response.cookies) if @config.client == :rest
        logger.info "#{page.request_method.to_s.upcase} #{page.url} #{response_times.last}s #{last_response.code}"
      end

      def request(page)
        time do
          @last_response = send(page.request_method, page)
        end
      end

      def get(page)
        case @config.client
        when :rest
          RestClient.get(page.url, :cookies => cookies)
        when :mechanize
          agent = Mechanize.new
          agent.get(page.url)
        end
      end

      def post(page)
        case @config.client
        when :rest
          RestClient.post(page.url, page.parameters, :cookies => cookies)
        when :mechanize
          Mechanize.new.post(page.url,page.parameters)
        end
      end
      
    private
      def sleep_interval
       (Random.new.rand(0.0..60.0)*@config.random_wait_interval.to_f)/60.0
      end
  end
end
