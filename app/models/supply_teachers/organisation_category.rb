module SupplyTeachers
  class OrganisationCategory
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

  OrganisationCategory.load_csv('supply_teachers/organisation_categories.csv')
end
