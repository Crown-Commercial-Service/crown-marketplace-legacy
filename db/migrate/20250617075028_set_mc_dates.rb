class SetMcDates < ActiveRecord::Migration[8.0]
  class Framework < ApplicationRecord
    self.table_name = 'frameworks'
  end

  def up
    mcf3 = Framework.find_by(framework: 'RM6187')
    mcf4 = Framework.find_by(framework: 'RM6309')

    mcf3&.update(expires_at: Time.new(2025, 8, 23).in_time_zone('London'))
    mcf4&.update(live_at: Time.new(2025, 8, 23).in_time_zone('London'), expires_at: Time.new(2028, 8, 23).in_time_zone('London'))
  end

  def down
    mcf3 = Framework.find_by(framework: 'RM6187')
    mcf4 = Framework.find_by(framework: 'RM6309')

    mcf3&.update(expires_at: Time.new(2025, 9, 4).in_time_zone('London'))
    mcf4&.update(live_at: Time.new(2025, 9, 4).in_time_zone('London'), expires_at: Time.new(2028, 9, 4).in_time_zone('London'))
  end
end
