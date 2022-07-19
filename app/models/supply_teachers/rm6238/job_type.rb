module SupplyTeachers
  module RM6238
    class JobType
      include Virtus.model
      include StaticRecord

      attribute :code, String
      attribute :description, String
      attribute :role, Axiom::Types::Boolean
      attribute :term_allowed, Axiom::Types::Boolean

      def self.[](code)
        find_by(code: code).description
      end

      def self.find_role_by(code:)
        find_by(code: code, role: true)
      end

      def self.find_term_allowed_by(code:)
        find_by(code: code, term_allowed: true)
      end

      def self.roles
        where(role: true)
      end

      def self.all_codes
        all.map(&:code)
      end
    end

    JobType.load_csv('supply_teachers/rm6238/job_types.csv')
  end
end
