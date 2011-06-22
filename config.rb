Trample.configure do
  client :mechanize #or :rest
  concurrency 800
  iterations  4
  rampup_interval 0.001 #wait time between spawning session threads
  random_wait_interval 35 #max wait time between each session requeset.  random between 0 and this value
  
  ## POST NOT WORKING FOR :mechanize client.  :rest only
  #login do
  #  post "http://yoursite.com/login" do
  #    {:username => User.random.username, :password => "swordfish"}
  #  end
  #end
  get  "http://shopping.transformingmedia.net/microsites/559171f09451d69e46f5aae1a5d4393650a9d84d"
  get  "http://shopping.transformingmedia.net/microsites/show_all_stores?microsite_id=559171f09451d69e46f5aae1a5d4393650a9d84d"
  get  "http://shopping.transformingmedia.net/microsites/show_all_categories?microsite_id=559171f09451d69e46f5aae1a5d4393650a9d84d"
  get  "http://shopping.transformingmedia.net/microsites/show_brand?id=19797&microsite_id=559171f09451d69e46f5aae1a5d4393650a9d84d"
  #post "http://yoursite.com/something" do
  #  {:a_parameter => "a value"}
  #end
  #get  "http://yoursite.com/someresources/:id" do
  #  {:id => SomeResource.random.id}
  #end
end
