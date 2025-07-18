class UpdateFrameworksData < ActiveRecord::Migration[8.0]
  def up
    ActiveRecord::Base.connection.truncate_tables(:jurisdictions, :supplier_framework_lot_jurisdictions)

    Rake::Task['db:update_frameworks'].invoke
  end

  def down; end
end
