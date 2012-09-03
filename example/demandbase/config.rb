require 'active_support/core_ext/array/random_access.rb'
require 'active_support/core_ext/array/access.rb'

# Staging
# HOST = "http://sandbox.staging.cloudfactory.com/api/v1"

# PUBLIC_LINE = "taken/demandbase-cf-safal"

# USERS = [ %w(stress2@sprout-technology.com ee75fbdf94928b000101f8bdfa95f0bcef0a0dc8),
#           %w(stress3@sprout-technology.com c9b985230aeb3448d15472fde93f916387312a70),
#           %w(stress4@sprout-technology.com 1e3754f7398ab815c000f6c65b02fde7957b9004),
#           %w(stress5@sprout-technology.com 00bc51e0cdabcd174107e5f065dd9823c33f4ac0),
#           %w(stress6@sprout-technology.com c8df40def5e5e7427ec9ae858cc0f907df644dea)]

# Local lvh.me

# HOST = "http://lvh.me:3000/api/v1"

# PUBLIC_LINE = "taken/demandbase-cf-safal"

USERS = [ %w(stress2@sprout-technology.com c6550ae5a060f0a03b5ec32cb81f8d48a0e5dfdf),
          %w(stress3@sprout-technology.com 68d8ef659207bd240b5cd9057dc7b2fe09f58354),
          %w(stress4@sprout-technology.com d8a84f400083c2f978410ce62323c327b1a20822),
          %w(stress5@sprout-technology.com 814bbaeb125f084add25bfef6e0131c865749305),
          %w(stress6@sprout-technology.com 317b35c795f9baf56f2157c81e18ca1ff19bb1b1)]
          
Trample.configure do
  concurrency 10
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
    {:data => {:run => {:title => "load-test-#{Time.new.strftime('%m_%d_%Y_%I_%M_%S_%p_%L')}"}}, :file => File.new(File.expand_path("../input/demand-base-bak2.csv", __FILE__), 'rb')}
  end
   
  # get "#{HOST}/lines/#{account.last}.json?api_key=#{account.second}"

  # post "http://yoursite.com/something" do
  #   {:a_parameter => "a value"}
  # end
  # get  "http://yoursite.com/someresources/:id" do
  #   {:id => SomeResource.random.id}
  # end
end
