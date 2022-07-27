module LegalServices
  module Admin
    class UploadsController < LegalServices::Admin::FrameworkController
      include SharedPagesConcern
      include ::Admin::UploadsController
    end
  end
end
