namespace :setup do
  
  desc "Create indexes for mongodb"
  task create_indexes: :environment do
    Rake::Task["db:mongoid:create_indexes"].invoke
  end

  desc "Delete indexes for mondodb"
  task remove_indexes: :environment do
    Rake::Task["db:mongoid:remove_indexes"].invoke
  end
end
