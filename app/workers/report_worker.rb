class ReportWorker
  include Sidekiq::Worker

  sidekiq_options queue: 'legacy_default', retry: false

  def perform(id)
    ReportCsvGenerator.new(id).generate
  end
end
