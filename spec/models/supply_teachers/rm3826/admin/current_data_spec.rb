require 'rails_helper'

RSpec.describe SupplyTeachers::RM3826::Admin::CurrentData, type: :model do
  describe '#validations' do
    context 'when no instances exist' do
      it 'validation fails' do
        expect(build(:supply_teachers_rm3826_admin_current_data)).to be_valid
      end
    end

    context 'when one instance already exists' do
      it 'validation fails' do
        create(:supply_teachers_rm3826_admin_current_data)
        expect(build(:supply_teachers_rm3826_admin_current_data)).not_to be_valid
      end
    end
  end
end
