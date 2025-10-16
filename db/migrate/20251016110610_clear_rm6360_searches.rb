class ClearRM6360Searches < ActiveRecord::Migration[8.0]
  class Searches < ApplicationRecord
    self.table_name = 'searches'
  end

  def up
    Searches.where(framework_id: 'RM6360').destroy_all
  end

  def down; end
end
