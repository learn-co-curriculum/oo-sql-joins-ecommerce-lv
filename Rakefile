require_relative './config/environment'

namespace :db do
  desc "Migrate the database by calling class create_table methods."
  task :migrate do
    Dir["./lib/*.rb"].each do |model_file|
      model_name = model_file.gsub("./lib/", "").gsub(".rb", "").capitalize
      model = Kernel.const_get(model_name)
      if model.respond_to?(:create_table)
        puts "Migrating #{model_name}..."
        model.create_table
      end
    end
  end
end
