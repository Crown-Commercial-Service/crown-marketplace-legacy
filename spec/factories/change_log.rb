FactoryBot.define do
  factory :change_log, class: 'ChangeLog' do
    change_type { 'upload_supplier_data' }

    user { association(:user) }

    after(:build) do |change_log, evaluator|
      change_log.framework ||= evaluator.framework || create(:framework)
    end
  end
end
