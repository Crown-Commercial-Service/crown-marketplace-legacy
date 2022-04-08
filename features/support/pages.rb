module Pages
  def home_page
    @home_page ||= Home.new
  end

  def journey_page
    @journey_page ||= Journey.new
  end

  def mc_page
    @mc_page ||= MC.new
  end
end
