RACK_ENV ||= ENV['RACK_ENV'] || 'development'
set :environment, RACK_ENV.to_sym

# Load db config and establish connection
ActiveRecord::Base.establish_connection YAML.load(File.read(File.join(File.dirname(__FILE__), 'database.yml'))).with_indifferent_access[RACK_ENV]