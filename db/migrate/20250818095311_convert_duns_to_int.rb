class ConvertDunsToInt < ActiveRecord::Migration[8.0]
  class Suppliers < ApplicationRecord
    self.table_name = 'suppliers'
  end

  def up
    Suppliers.where.not(duns_number: nil).find_each do |supplier|
      supplier.update(duns_number: supplier.duns_number.to_i.to_s)
    end
  end

  def down; end
end
