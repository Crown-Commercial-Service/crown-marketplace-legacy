class ReportExport
  class << self
    def call(report)
      CSV.generate do |csv|
        csv << create_headers_row
        find_searches(report).each { |search| csv << create_search_row(search) }
      end
    end

    private

    def create_headers_row
      ['User ID', 'Search date'] + search_criteria_headers + ['Suppliers']
    end

    def create_search_row(search)
      [search.user.id, format_date_time(search.created_at)] + search_criteria_row(search) + [search.search_result.map(&:first).sort.join(";\n")]
    end

    def search_criteria_headers
      NotImplementedError
    end

    def search_criteria_row(_search_criteria)
      NotImplementedError
    end

    def find_searches(report)
      report.framework.searches.where(created_at: (report.start_date..(report.end_date + 1))).where.not(user_id: test_user_ids).order(created_at: :desc)
    end

    def format_date_time(date_object)
      date_object.in_time_zone('London').strftime '%e %B %Y, %l:%M%P'
    end

    def test_user_ids
      User.where(email: ENV.fetch('TEST_USER_EMAILS', '').split(',')).pluck(:id)
    end
  end
end
