$: << "."

require 'sinatra'
require 'sinatra/activerecord'
require 'active_record'
require 'json'

require 'models/items'
require 'helpers'

set :database, "sqlite://db/preeventualist.db"

get "/" do
  erb :homepage
end

get "/lost" do
  erb :lost
end

get "/lost/search" do
  if not params["q"]
    status 400
    return invalid_query_response
  end

  validate_count

  return search_response_for Items.where(:item => params["q"]).limit params["count"]
end

get "/lost/searchlost" do
  if not params["q"]
    status 400
    return invalid_query_response
  end

  validate_count

  return search_response_for Items.where(:kind => "lost", :item => params["q"]).limit params["count"]
end

get "/lost/searchfound" do
  if not params["q"]
    status 400
    return invalid_query_response
  end

  validate_count

  return search_response_for Items.where(:kind => "found", :item => params["q"]).limit params["count"]
end

# This should really be POST, but Poignant Guide's API didn't distinguish
get "/lost/addlost" do
  missing_inputs = input_errors :lost
  if not missing_inputs.empty?
    return invalid_input_response_for missing_inputs
  end

  item = Items.new do |i|
    i.name        = params["name"]
    i.item        = params["item"]
    i.location    = params["seen"]
    i.description = params["desc"]
    i.kind        = "lost"
  end

  item.save

  submission_confirmation
end

get "/lost/addfound" do
  missing_inputs = input_errors :found
  if not missing_inputs.empty?
    return invalid_input_response_for missing_inputs
  end

  item = Items.new do |i|
    i.name        = params["name"]
    i.item        = params["item"]
    i.location    = params["at"]
    i.description = params["desc"]
    i.kind        = "found"
  end

  item.save

  submission_confirmation
end
