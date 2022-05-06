module SpecSupport
  module VisitStartPages
    def visit_supply_teachers_rm3826_start
      visit '/supply-teachers/RM3826'
      click_on 'Start now'
    end
  end
end

RSpec.configure do |config|
  config.include SpecSupport::VisitStartPages, type: :feature

  Capybara.javascript_driver = :selenium
end
