require 'rubygems'
require 'httparty'

class GoldPrice
  include HTTParty
  base_uri "www.quandl.com/"

  def posts
    self.class.get('/api/v3/datasets/WGC/GOLD_DAILY_GBP.json')
  end
end
