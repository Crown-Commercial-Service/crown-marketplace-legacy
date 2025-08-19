class AddBankHolidaysTable < ActiveRecord::Migration[8.0]
  def change
    create_table :bank_holidays do |t|
      t.text :title
      t.date :date, index: true
      t.text :notes
      t.boolean :bunting

      t.timestamps
    end
  end
end
