FactoryBot.define do
  factory :framework, class: 'Framework' do
    id { "FK#{Array.new(4) { rand(10) }.join}" }
    service { ('a'..'z').to_a.sample(8).join }
    live_at { 1.year.from_now }
    expires_at { 2.years.from_now }
  end
end
