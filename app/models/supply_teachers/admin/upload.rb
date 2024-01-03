module SupplyTeachers
  module Admin
    class Upload < ApplicationRecord
      include AASM

      self.abstract_class = true

      default_scope { order(created_at: :desc) }

      FILE_TO_EXTENSION = { current_accredited_suppliers: 'xlsx', geographical_data_all_suppliers: 'xlsx', lot_1_and_lot_2_comparisons: 'xlsx', master_vendor_contacts: 'csv', neutral_vendor_contacts: 'csv', education_technology_platform_contacts: 'csv', pricing_for_tool: 'xlsx', supplier_lookup: 'csv' }.freeze

      # input files on both frameworks
      has_one_attached :current_accredited_suppliers
      has_one_attached :geographical_data_all_suppliers
      has_one_attached :master_vendor_contacts
      has_one_attached :pricing_for_tool
      has_one_attached :supplier_lookup

      # output file
      has_one_attached :data

      validate :any_attached?, :file_ext_validation, on: :create

      validates :current_accredited_suppliers, antivirus: { message: :malicious }, size: { less_than: 10.megabytes, message: :too_large }, content_type: { with: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', message: :wrong_content_type }, on: :create
      validates :geographical_data_all_suppliers, antivirus: { message: :malicious }, size: { less_than: 10.megabytes, message: :too_large }, content_type: { with: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', message: :wrong_content_type }, on: :create
      validates :master_vendor_contacts, antivirus: { message: :malicious }, size: { less_than: 10.megabytes, message: :too_large }, content_type: { with: 'text/csv', message: :wrong_content_type }, on: :create
      validates :pricing_for_tool, antivirus: { message: :malicious }, size: { less_than: 10.megabytes, message: :too_large }, content_type: { with: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', message: :wrong_content_type }, on: :create
      validates :supplier_lookup, antivirus: { message: :malicious }, size: { less_than: 10.megabytes, message: :too_large }, content_type: { with: 'text/csv', message: :wrong_content_type }, on: :create

      after_validation :cancel_previous_uploads_and_copy_data, on: :create

      aasm do
        state :not_started, initial: true
        state :processing_files, :files_processed, :rejected, :canceled, :uploading, :published, :failed
        event :start_upload do
          transitions from: :not_started, to: :processing_files
          after do
            service::DataImportWorker.perform_async(id)
          end
        end
        event :files_processing_complete do
          transitions from: :processing_files, to: :files_processed
        end
        event :approve do
          transitions from: :files_processed, to: :uploading
          after do
            service::DataUploadWorker.perform_async(id)
          end
        end
        event :publish do
          transitions from: :uploading, to: :published
        end
        event :reject do
          transitions from: :files_processed, to: :rejected, after: :cleanup_input_files
        end
        event :cancel do
          transitions from: %i[not_started processing_files files_processed uploading], to: :canceled, after: :cleanup_input_files
        end
        event :fail do
          transitions from: %i[not_started processing_files uploading], to: :failed, after: :cleanup_input_files
        end
      end

      def files_count
        self.class::ATTRIBUTES.count { |uploaded_file| send(uploaded_file).attached? }
      end

      def short_uuid
        id[0..7]
      end

      def self.previous_uploaded_file(attr_name)
        previous_uploaded_file_upload(attr_name).try(:send, attr_name)
      end

      def self.previous_uploaded_file_upload(attr_name)
        where(aasm_state: :published).joins(:"#{attr_name}_attachment").first
      end

      def self.in_upload_progress
        not_started + processing_files + files_processed + uploading
      end

      private

      def any_attached?
        errors.add :base, :none_attached unless self.class::ATTRIBUTES.any? { |attr| send(attr).attached? }
      end

      def file_ext_validation
        self.class::ATTRIBUTES.each do |attr|
          next unless send(attr).attached?

          errors.add(attr, :wrong_extension) unless send(attr).blob.filename.to_s.end_with?(".#{FILE_TO_EXTENSION[attr]}")
        end
      end

      def cancel_previous_uploads_and_copy_data
        return if errors.any?

        cancel_previous_uploads
        copy_files_to_current_data
      rescue StandardError => e
        errors.add(:base, e.message)
      end

      def copy_files_to_current_data
        current_data = service::CurrentData.first_or_create
        self.class::ATTRIBUTES.each do |attr|
          current_data.send(attr).attach(send(attr).blob) if send(attr).attached?
        end
        current_data.save
      end

      def cancel_previous_uploads
        self.class.not_started.map(&:cancel!)
        self.class.processing_files.map(&:cancel!)
        self.class.files_processed.map(&:cancel!)
        self.class.uploading.map(&:cancel!)
      end

      def cleanup_input_files
        current_data = service::CurrentData.first_or_create
        self.class::ATTRIBUTES.each do |attr|
          previous_upload_file = self.class.previous_uploaded_file(attr)

          current_data.send(attr).attach(previous_upload_file.blob) if available_for_cp(previous_upload_file, attr)
        end
        current_data.save!
      end

      def available_for_cp(previous_upload_file, attr_name)
        send(attr_name).attached? && previous_upload_file.try(:attached?)
      end

      def service
        @service ||= self.class.module_parent
      end
    end
  end
end
