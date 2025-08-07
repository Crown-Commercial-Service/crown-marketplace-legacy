class ImportNewFrameworkData < ActiveRecord::Migration[8.0]
  def up
    # Disabled as we only want the last instance of this to be run on any given environment
    # Rake::Task['db:update_frameworks'].invoke
  end

  def down; end
end
