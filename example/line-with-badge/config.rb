require 'active_support/core_ext/array/random_access.rb'
require 'active_support/core_ext/array/access.rb'

HOST = "http://sandbox.staging.cloudfactory.com/api/v1"

PUBLIC_LINE = "taken/load-testing-line"

USERS = [ %w(stress2@sprout-technology.com ee75fbdf94928b000101f8bdfa95f0bcef0a0dc8),
          %w(stress3@sprout-technology.com c9b985230aeb3448d15472fde93f916387312a70),
          %w(stress4@sprout-technology.com 1e3754f7398ab815c000f6c65b02fde7957b9004),
          %w(stress5@sprout-technology.com 00bc51e0cdabcd174107e5f065dd9823c33f4ac0),
          %w(stress6@sprout-technology.com c8df40def5e5e7427ec9ae858cc0f907df644dea)]
          
Trample.configure do
  concurrency 40
  iterations  4
  client :rest
  rampup_interval 0.05 #wait time between spawning session threads
  random_wait_interval 15

  login do
    post "#{HOST}/account_login.json" do
      {:user => {:email => USERS.sample.first, :password => "swordfish"}}
    end
  end

  post "#{HOST}/lines/#{PUBLIC_LINE}/runs.json?api_key=#{USERS.sample.second}" do
    {:data => {:run => {:title => "load-test-#{Time.new.strftime('%m_%d_%Y_%I_%M_%S_%p_%L')}"}}, :file => File.new(File.expand_path("../input/sample-data.csv", __FILE__), 'rb')}
  end

  # get "#{HOST}/lines/#{account.last}.json?api_key=#{account.second}"

  # post "http://yoursite.com/something" do
  #   {:a_parameter => "a value"}
  # end
  # get  "http://yoursite.com/someresources/:id" do
  #   {:id => SomeResource.random.id}
  # end
end
