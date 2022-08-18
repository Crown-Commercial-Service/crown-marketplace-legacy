class AddRM6240Upload < ActiveRecord::Migration[6.0]
  def change
    create_table :legal_services_rm6240_uploads, id: :uuid, &:timestamps
  end
end
