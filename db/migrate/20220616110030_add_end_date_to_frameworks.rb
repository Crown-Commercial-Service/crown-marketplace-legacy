class AddEndDateToFrameworks < ActiveRecord::Migration[6.0]
  def change
    add_column :frameworks, :expires_at, :date
  end
end
