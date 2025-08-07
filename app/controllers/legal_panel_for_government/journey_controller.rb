module LegalPanelForGovernment
  class JourneyController < LegalPanelForGovernment::FrameworkController
    include JourneyControllerActions

    def journey_class
      Journey
    end
  end
end
