FactoryBot.define do
  factory :buyer_detail, class: 'BuyerDetail' do
    name { Faker::Name.unique.name }
    job_title { Faker::Company.profession }
    organisation_name { Faker::Company.unique.name }
    organisation_sector { 'defence_and_security' }

    after(:build) do |buyer_detail, evaluator|
      buyer_detail.user ||= evaluator.user || create(:user)
    end
  end
end
