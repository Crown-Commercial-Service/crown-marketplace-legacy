class AddFrameworkAnalyticsTable < ActiveRecord::Migration[8.0]
  def change
    create_table :searches, id: :uuid do |t|
      t.references :user, type: :uuid, foreign_key: true, index: true, null: false
      t.references :framework, type: :text, foreign_key: true, index: true, null: false
      t.uuid :session_id
      t.text :search_criteria
      t.text :search_result

      t.timestamps
    end
  end

  create_table :reports, id: :uuid do |t|
    t.references :user, type: :uuid, foreign_key: true, index: true, null: false
    t.references :framework, type: :text, foreign_key: true, index: true, null: false
    t.string :aasm_state, limit: 30
    t.date :start_date
    t.date :end_date

    t.timestamps
  end
end
