RSpec.shared_context 'and RM6238 is live in the future' do
  before { Framework.find_by(framework: 'RM6238').update(live_at: 1.day.from_now) }
end

RSpec.shared_context 'and RM6238 is live today' do
  before { Framework.find_by(framework: 'RM6238').update(live_at: Time.zone.now) }
end

RSpec.shared_context 'and RM6238 has expired' do
  before { Framework.find_by(framework: 'RM6238').update(expires_at: Time.zone.now) }
end

RSpec.shared_context 'and RM6240 is live in the future' do
  before { Framework.find_by(framework: 'RM6240').update(live_at: 1.day.from_now) }
end

RSpec.shared_context 'and RM6240 is live today' do
  before { Framework.find_by(framework: 'RM6240').update(live_at: Time.zone.now) }
end

RSpec.shared_context 'and RM6240 has expired' do
  before { Framework.find_by(framework: 'RM6240').update(expires_at: Time.zone.now) }
end

RSpec.shared_context 'and RM6187 has expired' do
  before { Framework.find_by(framework: 'RM6187').update(expires_at: Time.zone.now) }
end
