module SupplyTeachers
  module RM3826
    class JobType
      include Virtus.model
      include StaticRecord

      attribute :code, String
      attribute :description, String
      attribute :role, Axiom::Types::Boolean

      def self.[](code)
        find_by(code: code).description
      end

      def self.find_role_by(code:)
        find_by(code: code, role: true)
      end

      def self.roles
        where(role: true)
      end

      def self.all_codes
        all.map(&:code)
      end

      def role?
        role
      end
    end

    JobType.load_csv('supply_teachers/rm3826/job_types.csv')
  end
end
