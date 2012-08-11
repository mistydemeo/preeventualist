require 'uri'

Given /^a "([^\"]*)" (found|lost) by "([^\"]*)" in "([^\"]*)" is in the database with the description:$/ do |item, kind, name, location, description|
  item = Items.new do |i|
    i.name        = name
    i.item        = item
    i.location    = location
    i.description = description
    i.kind        = kind
  end

  item.save
end

When /^I search for a (\w+) "([^\"]*)"$/ do |mode, text|
  p "/lost/search#{mode}?q=#{text}"
  visit "/lost/search#{mode}?q=#{text}"
end

When /^"([^\"]*)" submits a (lost|found) "([^\"]*)" (seen in|found at) "([^\"]*)" with the description:$/ do |name, mode, item, _, location, description|
  params = {
    name: name,
    item: item,
    desc: description
  }
  if mode == "lost"
    params[:seen] = location
  else
    params[:at] = location
  end

  query = params.map {|k,v| URI.escape("#{k}=#{v}")}.join("&")
  visit "/lost/add#{mode}?" + query
end

Then /^I should see:$/ do |text|
  if page.respond_to? :should
    page.should have_content(text)
  else
    assert page.has_content?(text)
  end
end