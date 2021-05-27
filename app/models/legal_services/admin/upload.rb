module LegalServices
  module Admin
    class Upload < ApplicationRecord
      include AASM
      self.table_name = 'legal_services_admin_uploads'
      default_scope { order(created_at: :desc) }
      serialize :import_errors, Array

      ATTRIBUTES = %i[supplier_details_file supplier_rate_cards_file supplier_lot_1_service_offerings_file supplier_lot_2_service_offerings_file supplier_lot_3_service_offerings_file supplier_lot_4_service_offerings_file].freeze

      has_one_attached :supplier_details_file
      has_one_attached :supplier_rate_cards_file
      has_one_attached :supplier_lot_1_service_offerings_file
      has_one_attached :supplier_lot_2_service_offerings_file
      has_one_attached :supplier_lot_3_service_offerings_file
      has_one_attached :supplier_lot_4_service_offerings_file

      validate :supplier_files_attached, on: :upload
      validate :supplier_files_ext_validation, on: :upload

      validates :supplier_details_file, :supplier_rate_cards_file, :supplier_lot_1_service_offerings_file, :supplier_lot_2_service_offerings_file, :supplier_lot_3_service_offerings_file, :supplier_lot_4_service_offerings_file, antivirus: { message: :malicious }, size: { less_than: 10.megabytes, message: :too_large }, content_type: { with: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', message: :wrong_content_type }, on: :upload

      aasm do
        state :not_started, initial: true
        state :in_progress
        state :checking_files
        state :processing_files
        state :checking_processed_data
        state :publishing_data
        state :published
        state :failed
        event :start_upload do
          transitions from: :not_started, to: :in_progress
          after do
            LegalServices::FileUploadWorker.perform_async(id)
          end
        end
        event :check_files do
          transitions from: :in_progress, to: :checking_files
        end
        event :process_files do
          transitions from: :checking_files, to: :processing_files
        end
        event :check_processed_data do
          transitions from: :processing_files, to: :checking_processed_data
        end
        event :publish_data do
          transitions from: :checking_processed_data, to: :publishing_data
        end
        event :publish do
          transitions from: :publishing_data, to: :published
        end
        event :fail do
          transitions from: %i[not_started in_progress checking_files processing_files checking_processed_data publishing_data published], to: :failed
        end
      end

      def short_uuid
        id[0..7]
      end

      def self.latest_upload
        published.order(created_at: :desc).first
      end

      private

      def supplier_files_attached
        ATTRIBUTES.each do |file|
          errors.add(file, :not_attached) unless send(file).attached?
        end
      end

      def supplier_files_ext_validation
        ATTRIBUTES.each do |file|
          next unless send(file).attached?

          errors.add(file, :wrong_extension) unless send(file).blob.filename.to_s.end_with?('.xlsx')
        end
      end
    end
  end
end
