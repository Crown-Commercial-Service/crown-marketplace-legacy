FactoryBot.define do
  factory :jurisdiction, class: 'Jurisdiction' do
    initialize_with do
      country_code = Faker::Address.unique.country_code

      jurisdiction = Jurisdiction.find_by(id: country_code)

      if jurisdiction.present?
        jurisdiction
      else
        new(id: country_code, name: Faker::Address.unique.country, mapping_name: Faker::Address.unique.country)
      end
    end
  end
end
