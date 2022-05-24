FactoryBot.define do
  factory :legacy_framework, class: 'Framework' do
    id { SecureRandom.uuid }
    service { ('a'..'z').to_a.sample(8).join }
    framework { "FK#{Array.new(4) { rand(10) }.join}" }
    live_at { Time.zone.now + 1.year }
  end
end
