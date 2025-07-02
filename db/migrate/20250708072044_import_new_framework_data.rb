class ImportNewFrameworkData < ActiveRecord::Migration[8.0]
  def up
    Rake::Task['db:update_frameworks'].invoke
  end

  def down; end
end
