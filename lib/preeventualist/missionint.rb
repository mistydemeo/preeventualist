require 'json'
require 'net/http'
require 'uri'

# This is unused because response times are unbearably slow.
# But might as well leave the code here, eh?
class MissionInteger
  def initialize
    uri = URI("http://www.missionintegers.com/next-int")
    response = Net::HTTP.post_form uri, "format" => "json"
    @integer = JSON.parse(response.body).first.to_i
  end

  def to_i
    @integer
  end
end