require 'elasticsearch/model'

if ENV['BONSAI_URL']
  Elasticsearch::Model.client = Elasticsearch::Client.new({url: ENV['BONSAI_URL'], logs: true})
  BONSAI_INDEX_NAME = ENV['BONSAI_URL'][/[^\/]+$/]
end