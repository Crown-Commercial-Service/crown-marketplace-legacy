class BankHolidaysWorker
  include Sidekiq::Worker

  sidekiq_options queue: 'legacy_default', retry: false

  def perform
    DataLoader::BankHolidays.add_bank_holidays_from_csv_data_and_api
  end
end
