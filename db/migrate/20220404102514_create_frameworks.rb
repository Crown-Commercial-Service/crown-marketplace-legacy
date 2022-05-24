class CreateFrameworks < ActiveRecord::Migration[6.0]
  def change
    create_table :frameworks, id: :uuid do |t|
      t.string :service, limit: 25
      t.string :framework, limit: 6
      t.date :live_at

      t.timestamps
    end
  end
end
