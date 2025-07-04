class AddFrameworkUploadsTable < ActiveRecord::Migration[8.0]
  def change
    create_table :uploads, id: :uuid do |t|
      t.references :framework, type: :text, foreign_key: true, index: true, null: false

      t.timestamps
    end
  end
end
