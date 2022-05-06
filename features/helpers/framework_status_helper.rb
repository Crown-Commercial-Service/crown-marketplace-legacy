def open_rm3788_framework
  Framework.find_by(framework: 'RM6240').update(live_at: Time.zone.now + 1.day)
end

def open_rm3826_framework
  Framework.find_by(framework: 'RM6238').update(live_at: Time.zone.now + 1.day)
end
