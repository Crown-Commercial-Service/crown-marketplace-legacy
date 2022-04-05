module Pages
  def home_page
    @home_page ||= Home.new
  end
end
