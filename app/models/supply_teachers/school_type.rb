module SupplyTeachers
  class SchoolType
    include ActiveModel::Model
    include ActiveModel::Attributes
    include StaticRecord

    attribute :id, :string
    attribute :name, :string
    attribute :non_profit, :boolean

    def non_profit?
      non_profit
    end
  end

  SchoolType.load_csv('supply_teachers/school_types.csv')
end
