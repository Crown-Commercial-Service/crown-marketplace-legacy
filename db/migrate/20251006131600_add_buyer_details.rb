class AddBuyerDetails < ActiveRecord::Migration[8.0]
  def change
    create_table :buyer_details, id: :uuid do |t|
      t.references :user, type: :uuid, foreign_key: true, index: true, null: false
      t.text :name, limit: 255
      t.text :job_title, limit: 255
      t.text :organisation_name, limit: 255
      t.text :organisation_sector, limit: 255

      t.timestamps
    end
  end
end
