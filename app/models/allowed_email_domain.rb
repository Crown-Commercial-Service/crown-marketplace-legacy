class AllowedEmailDomain
  include ActiveModel::Model

  attr_accessor :email_domain

  def domain_in_allow_list?
    allow_list.include? email_domain&.downcase
  end

  def allow_list
    @allow_list ||= if Rails.env.production?
                      allow_list_s3_object.get.body.string.split("\n")
                    else
                      File.read(allow_list_file_path).split
                    end
  end

  private

  def allow_list_s3_object
    @allow_list_s3_object ||= Aws::S3::Resource.new(region: ENV.fetch('COGNITO_AWS_REGION', nil)).bucket(ENV.fetch('CCS_APP_API_DATA_BUCKET', nil)).object(ENV.fetch('ALLOW_LIST_KEY', nil))
  end

  def allow_list_file_path
    @allow_list_file_path ||= Rails.root.join(ENV.fetch('ALLOWED_EMAIL_DOMAINS_FILE_PATH', nil))
  end
end
