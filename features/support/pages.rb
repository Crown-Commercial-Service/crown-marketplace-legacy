module Pages
  def home_page
    @home_page ||= Home.new
  end

  def journey_page
    @journey_page ||= Journey.new
  end

  def supply_teachers_page
    @supply_teachers_page ||= SupplyTeachers.new
  end
end
