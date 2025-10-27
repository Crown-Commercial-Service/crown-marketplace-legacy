FactoryBot.define do
  factory :search, class: 'Search' do
    session_id { SecureRandom.uuid }
    search_criteria { { criteria: true } }
    search_result { [['MABEL', '1'], ['CHARLES', '2'], ['OLIVER', '3']] }

    user { association(:user) }

    after(:build) do |search, evaluator|
      search.framework ||= evaluator.framework || create(:framework)
      search.search_criteria_hash ||= Digest::SHA256.hexdigest(search.search_criteria.sort.to_h.to_s)
    end
  end
end
