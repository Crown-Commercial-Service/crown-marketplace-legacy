class AddMcf4ToFrameworksTable < ActiveRecord::Migration[7.1]
  class Framework < ApplicationRecord
    self.table_name = 'frameworks'
  end

  def up
    Framework.create(service: 'management_consultancy', framework: 'RM6309', live_at: Time.new(2025, 9, 4).in_time_zone('London'), expires_at: Time.new(2028, 9, 4).in_time_zone('London')) unless Framework.find_by(framework: 'RM6309')
  end

  def down
    Framework.find_by(framework: 'RM6309')&.delete
  end
end
