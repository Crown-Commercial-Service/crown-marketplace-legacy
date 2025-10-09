module Pages
  def admin_page
    @admin_page ||= Admin.new
  end

  def home_page
    @home_page ||= Home.new
  end

  def journey_page
    @journey_page ||= Journey.new
  end

  def buyer_detail_page
    @buyer_detail_page ||= BuyerDetailPage.new
  end

  def supply_teachers_page
    @supply_teachers_page ||= SupplyTeachers.new
  end

  def legal_panel_for_government_page
    @legal_panel_for_government_page ||= LegalPanelForGovernment.new
  end
end
