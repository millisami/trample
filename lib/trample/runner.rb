module Trample
  class Runner
    include Logging

    attr_reader :config, :threads, :all_response_times

    def initialize(config)
      @config  = config
      @threads = []
      @all_response_times = []
    end

    def trample
      logger.info "Starting trample..."

      config.concurrency.times do
        sleep(@config.rampup_interval)
        thread = Thread.new(@config) do |c|
          all_response_times << Session.new(c).trample
        end
        threads << thread
      end
      threads.each { |t| t.join }
      
      #sum it all up
      total_elapsed = 0
      total_requests = 0
      
      all_response_times.each_with_index do |thread_response_times,i|
        elapsed = thread_response_times.sum
        requests = thread_response_times.count
        logger.info "Thread #{i+1} completed in #{elapsed.round(4)} seconds, with an average of #{(elapsed/thread_response_times.count).round(4)} seconds per request"
        total_elapsed += elapsed
        total_requests += requests
      end
      
      logger.info "The total execution time was #{total_elapsed.round(4)} seconds, with a total of #{total_requests.round(4)} requests.  The average response time was #{(total_elapsed/total_requests).round(4)} seconds"
      logger.info "Trample completed..."
    end
  end
end

