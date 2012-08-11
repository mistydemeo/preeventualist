require 'json'
require 'net/http'
require 'uri'

class Brooklynt
  def initialize
    uri = URI("http://api.brooklynintegers.com/rest/")
    opts = {"method" => "brooklyn.integers.create"}
    response = Net::HTTP.post_form uri, opts
    @integer = JSON.parse(response.body)["integers"].first["integer"].to_i
  end

  def to_i
    @integer
  end
end