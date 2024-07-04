class RefactorFrameworksTable < ActiveRecord::Migration[7.1]
  class FrameworkOld < ApplicationRecord
    self.table_name = 'frameworks_old'
  end

  class Framework < ApplicationRecord
    self.table_name = 'frameworks'
  end

  def up
    rename_table :frameworks, :frameworks_old

    create_table :frameworks, id: :string, limit: 6 do |t|
      t.string :service, limit: 25
      t.date :live_at
      t.date :expires_at

      t.timestamps
    end

    FrameworkOld.find_each do |framework|
      Framework.create(
        id: framework.framework,
        service: framework.service,
        live_at: framework.live_at,
        expires_at: framework.expires_at
      )
    end

    drop_table :frameworks_old
  end

  def down
    create_table 'frameworks_old', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
      t.string 'service', limit: 25
      t.string 'framework', limit: 6
      t.date 'live_at'
      t.timestamps
      t.date 'expires_at'
    end

    Framework.find_each do |framework|
      FrameworkOld.create(
        framework: framework.id,
        service: framework.service,
        live_at: framework.live_at,
        expires_at: framework.expires_at
      )
    end

    drop_table :frameworks

    rename_table :frameworks_old, :frameworks
  end
end
