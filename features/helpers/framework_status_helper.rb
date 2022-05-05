def open_rm3830_framework
  Framework.find_by(framework: 'RM6240').update(live_at: Time.zone.now + 1.day)
end
