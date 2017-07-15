# require your app file first
require_relative './app'
require 'sinatra/activerecord/rake'

namespace :db do
  task :load_config do
    require "./app"
  end
end

desc "IRB Console"
task :console do
  system("irb -r ./app.rb")
end