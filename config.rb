Trample.configure do
  client :mechanize #or :rest
  concurrency 5
  iterations  10
  rampup_interval 2 #wait time between spawning session threads
  random_wait_interval 0.5 #max wait time between each session requeset.  random between 0 and this value
  
  ## POST NOT WORKING FOR :mechanize client.  :rest only
  #login do
  #  post "http://yoursite.com/login" do
  #    {:username => User.random.username, :password => "swordfish"}
  #  end
  #end
  get  "http://yoursite.com/somewhere"
  #post "http://yoursite.com/something" do
  #  {:a_parameter => "a value"}
  #end
  get  "http://yoursite.com/someresources/:id" do
    {:id => SomeResource.random.id}
  end
end
