require_relative 'config/environment'
require 'sinatra/activerecord/rake'

namespace :db do
  desc 'Drop, rollback, migrate then seed the development database'
  task reseed: [ 'db:drop', 'db:rollback', 'db:migrate'] do
    puts 'Reseeding completed.'
  end
end

desc 'starts a console'
task :console do
  Pry.start
end
