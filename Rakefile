require 'bundler'
require 'cucumber/rake/task'
require 'sinatra/activerecord/rake'
require './app'

Bundler::GemHelper.install_tasks

Cucumber::Rake::Task.new(:features) do |t|
  t.cucumber_opts = "--format pretty"
end