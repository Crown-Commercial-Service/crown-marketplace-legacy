class CreateSupplyTeachersRM6238Uploads < ActiveRecord::Migration[6.0]
  def change
    create_table :supply_teachers_rm6238_uploads, id: :uuid, &:timestamps
  end
end
