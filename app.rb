$: << File.join(__FILE__, "..")
$: << File.join(__FILE__, "../lib")

require 'sinatra'
require 'sinatra/activerecord'
require 'active_record'
require 'json'

require "config/config"

require 'models/items'
require 'models/post'
require 'models/poster'
require 'helpers'
require 'preeventualist/brooklynt'

get "/" do
  erb :homepage
end

get "/lost/?" do
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

  return search_response_for LostItem.where(:item => params["q"]).limit params["count"]
end

get "/lost/searchfound" do
  if not params["q"]
    status 400
    return invalid_query_response
  end

  validate_count

  return search_response_for FoundItem.where(:item => params["q"]).limit params["count"]
end

# This should really be POST, but Poignant Guide's API didn't distinguish
get "/lost/addlost" do
  missing_inputs = input_errors :lost
  if not missing_inputs.empty?
    return invalid_input_response_for missing_inputs
  end

  item = LostItem.new params

  item.save

  submission_confirmation item
end

get "/lost/addfound" do
  missing_inputs = input_errors :found
  if not missing_inputs.empty?
    return invalid_input_response_for missing_inputs
  end

  item = FoundItem.new params

  item.save

  submission_confirmation item
end

not_found do
  status 404
  erb :'404'
end

error do
  status 500
  erb :internal_error
end