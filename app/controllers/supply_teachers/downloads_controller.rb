module SupplyTeachers
  class DownloadsController < SupplyTeachers::FrameworkController
    before_action :authorize_user

    def index
      respond_to do |format|
        format.xlsx do
          spreadsheet = SupplyTeachers::AuditSpreadsheet.new
          send_data spreadsheet.to_xlsx, filename: 'supply_teachers.xlsx', type: :xlsx
        end
      end
    end

    protected

    def authorize_user
      authorize! :manage, SupplyTeachers::Admin::Upload
    end
  end
end
