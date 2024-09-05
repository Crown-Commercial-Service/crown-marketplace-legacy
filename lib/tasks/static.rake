namespace :db do
  desc 'add static data to the database'
  task static: :environment

  desc 'add static data to the database during setup'
  task setup: :static
end
