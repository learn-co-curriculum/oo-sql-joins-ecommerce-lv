require_relative './config/environment'

def migrate!
  Dir["./lib/*.rb"].each do |model_file|
    model_name = model_file.gsub("./lib/", "").gsub(".rb", "").split("_").collect{|s| s.capitalize}.join("")
    model = Kernel.const_get(model_name)
    if model.respond_to?(:create_table)
      puts "Migrating #{model_name}..."
      model.create_table
    end
  end
end

namespace :db do
  desc "Migrate the database by calling class create_table methods."
  task :migrate do
    migrate!
  end

  desc "Drop the database and re-migrate."
  task :reset do
    File.delete("./db/development.sqlite")
    DB[:connection] = SQLite3::Database.new("db/development.sqlite")

    migrate!
  end
end

def reload!
  load_all './lib'
end

task :console do
  Pry.start
end
