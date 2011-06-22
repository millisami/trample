require 'active_record'

ActiveRecord::Base.establish_connection(
   :adapter  => "mysql",
   :host     => "localhost",
   :username => "root",
   :password => "",
   :database => "couponshack3_production"
 )

class Brand < ActiveRecord::Base
end

class Blog < ActiveRecord::Base
end

class HotDeal < ActiveRecord::Base
end

class Store < ActiveRecord::Base
  def url_name
    self.name.tr(" ","-").tr(".","_").tr("&","_").tr(",","").tr("'","")
  end
end

stores = Store.where(:deleted=>0, :redirect_store_id=>nil)

Trample.configure do
  client :mechanize
  concurrency 1
  iterations  1
  rampup_interval 0.01
  random_wait_interval 0
  stores.each do |store|
    get "http://www.couponshack.com/stores/show/:id/:name" do
      {:id => store.id, :name=>store.url_name}
    end
  end
end
