class UpdateLotPositions < ActiveRecord::Migration[8.0]
  class Positions < ApplicationRecord
    self.table_name = 'positions'
  end

  class SupplierFrameworkLots < ApplicationRecord
    self.table_name = 'supplier_framework_lots'
  end

  class SupplierFrameworkLotRates < ApplicationRecord
    self.table_name = 'supplier_framework_lot_rates'
  end

  OLD_POSTION_TO_NEW_POSITION_MAPPING = [
    {
      framework_id: 'RM6238',
      lot_numbers: ['1', '2.1', '2.2'],
      mapping: [
        [38, 9],
        [39, 10],
        [40, 11],
        [41, 1],
        [42, 3],
        [43, 5],
        [44, 7],
        [46, 2],
        [47, 4],
        [48, 6],
        [49, 8]
      ]
    },
    {
      framework_id: 'RM6238',
      lot_numbers: ['4'],
      mapping: [
        [39, 3],
        [40, 4],
        [45, 1],
        [50, 2],
      ]
    },
    {
      framework_id: 'RM6187',
      lot_numbers: (1..9),
      mapping: [
        [8, 1],
        [9, 2],
        [10, 3],
        [11, 4],
        [12, 5],
        [13, 6],
      ]
    },
    {
      framework_id: 'RM6240',
      lot_numbers: ['1a', '1b', '1c', '2a', '2b', '2c', '3'],
      mapping: [
        [1, 1],
        [2, 2],
        [3, 3],
        [4, 4],
        [5, 5],
        [6, 6],
        [7, 7],
      ]
    },
    {
      framework_id: 'RM6309',
      lot_numbers: (1..9),
      mapping: [
        [14, 1],
        [15, 3],
        [16, 5],
        [17, 7],
        [18, 9],
        [19, 11],
        [20, 2],
        [21, 4],
        [22, 6],
        [23, 8],
        [24, 10],
        [25, 12],
      ]
    },
    {
      framework_id: 'RM6309',
      lot_numbers: [10],
      mapping: [
        [26, 1],
        [27, 3],
        [28, 5],
        [29, 7],
        [30, 9],
        [31, 11],
        [32, 2],
        [33, 4],
        [34, 6],
        [35, 8],
        [36, 10],
        [37, 12],
      ]
    },
    {
      framework_id: 'RM6360',
      lot_numbers: [1, 2, 3, 5],
      mapping: [
        [1, 1],
        [51, 2],
        [52, 3],
        [53, 4],
        [54, 5],
        [55, 6],
        [6, 7],
      ]
    },
    {
      framework_id: 'RM6360',
      lot_numbers: ['4a', '4b', '4c'],
      mapping: [
        [56, 1],
        [1, 2],
        [51, 3],
        [52, 4],
        [53, 5],
        [54, 6],
        [55, 7],
        [6, 8],
        [57, 9],
        [58, 10],
        [59, 11],
        [60, 12],
      ]
    },
  ].freeze

  # rubocop:disable Metrics/AbcSize
  def up
    remove_foreign_key :supplier_framework_lot_rates, :positions

    rename_table :positions, :old_positions
    rename_column :supplier_framework_lot_rates, :position_id, :old_position_id
    remove_index :supplier_framework_lot_rates, %i[supplier_framework_lot_id old_position_id supplier_framework_lot_jurisdiction_id]

    create_table :positions, id: :text, force: :cascade do |t|
      t.references :lot, type: :text, foreign_key: true, index: true, null: false
      t.integer :number, null: false
      t.text :name, null: false
      t.text :category

      t.timestamps
    end

    Positions.reset_column_information

    CSV.read(Rails.root.join('data', 'positions.csv'), headers: true).each do |row|
      Positions.create!(**row)
    end

    add_reference :supplier_framework_lot_rates, :position, type: :text, foreign_key: true, index: true
    add_index :supplier_framework_lot_rates, %i[supplier_framework_lot_id position_id supplier_framework_lot_jurisdiction_id], unique: true

    SupplierFrameworkLotRates.reset_column_information

    # rubocop:disable Rails/SkipsModelValidations
    OLD_POSTION_TO_NEW_POSITION_MAPPING.each do |mapping|
      mapping[:lot_numbers].each do |lot_number|
        lots_id = "#{mapping[:framework_id]}.#{lot_number}"

        mapping[:mapping].each do |old_position_id, new_position_id|
          SupplierFrameworkLotRates.where(
            supplier_framework_lot_id: SupplierFrameworkLots.where(lot_id: lots_id).select(&:id),
            old_position_id: old_position_id
          ).update_all(position_id: "#{lots_id}.#{new_position_id}")
        end
      end
    end
    # rubocop:enable Rails/SkipsModelValidations

    # rubocop:disable Rails/BulkChangeTable
    change_column_null :supplier_framework_lot_rates, :position_id, false
    # rubocop:enable Rails/BulkChangeTable
    remove_column :supplier_framework_lot_rates, :old_position_id
    drop_table :old_positions
  end
  # rubocop:enable Metrics/AbcSize

  def down; end
end
