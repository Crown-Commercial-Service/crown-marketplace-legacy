module SupplyTeachers
  module RM3826
    class Journey::SchoolPostcodeAgencySuppliedWorker
      include Steppable
      include Geolocatable

      def next_step_class
        Journey::FixedTermResults
      end
    end
  end
end
