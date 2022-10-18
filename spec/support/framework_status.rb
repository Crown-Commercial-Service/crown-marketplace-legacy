RSpec.shared_context 'and RM6238 is live in the future' do
  before { Framework.find_by(framework: 'RM6238').update(live_at: Time.zone.now + 1.day) }
end

RSpec.shared_context 'and RM6238 is live today' do
  before { Framework.find_by(framework: 'RM6238').update(live_at: Time.zone.now) }
end

RSpec.shared_context 'and RM6240 is live in the future' do
  before { Framework.find_by(framework: 'RM6240').update(live_at: Time.zone.now + 1.day) }
end

RSpec.shared_context 'and RM6240 is live today' do
  before { Framework.find_by(framework: 'RM6240').update(live_at: Time.zone.now) }
end

RSpec.shared_context 'and RM3788 has expired' do
  before { Framework.find_by(framework: 'RM3788').update(expires_at: Time.zone.now) }
end
