# rubocop:disable Metrics/ModuleLength
module GenerateAuthenticationSpecs
  def self.buyer_tag_to_value(service_name, framework)
    {
      module_service_name: "#{service_name.split('_').map(&:capitalize).join}::#{framework}",
      service_param_name: service_name,
      admin: '',
      start_path: "#{service_name}_journey_start_path",
      role: 'buyer',
      role_type: 'buyer'
    }
  end

  def self.admin_tag_to_value(service_name, framework)
    {
      module_service_name: "#{service_name.split('_').map(&:capitalize).join}::#{framework}::Admin",
      service_param_name: "#{service_name}/admin",
      admin: '_admin',
      start_path: "#{service_name}_#{framework.downcase}_admin_uploads_path",
      role: 'ccs_employee',
      role_type: 'admin'
    }
  end

  def self.generate_tag_to_value(service_name, framework, admin)
    base_tag_to_value = {
      service_name: service_name,
      service_code: service_name.split('_').map(&:first).join,
      FRAMEWORK: framework,
      framework: framework.downcase
    }

    base_tag_to_value.merge((admin ? admin_tag_to_value(service_name, framework) : buyer_tag_to_value(service_name, framework)))
  end

  # rubocop:disable Metrics/ParameterLists
  def self.generate_spec_file(framework, output_file_path, source_file_path, tag_to_value, registration, admin)
    source_file_text = File.read(source_file_path)

    tag_to_value.each do |key, value|
      source_file_text.gsub!("<#{key}>", value)
    end

    if registration
      source_file_text.gsub!('<registration_only>', '')
      source_file_text.gsub!('</registration_only>', '')
    else
      source_file_text.gsub!(REGISTRATION_ONLY_REGEX, '')
    end

    if admin
      source_file_text.gsub!("<admin_only>\n", '')
      source_file_text.gsub!("</admin_only>\n", '')
      source_file_text.gsub!(NON_ADMIN_ONLY_REGEX, '')
    else
      source_file_text.gsub!("<non_admin_only>\n", '')
      source_file_text.gsub!("</non_admin_only>\n", '')
      source_file_text.gsub!(ADMIN_ONLY_REGEX, '')
    end

    if framework == 'RM6187'
      source_file_text.gsub!("<rm6187_only>\n", '')
      source_file_text.gsub!("</rm6187_only>\n", '')
    else
      source_file_text.gsub!(RM6187_ONLY_REGEX, '')
    end

    File.write(output_file_path, source_file_text)
  end
  # rubocop:enable Metrics/ParameterLists

  def self.generate_sessions_controller_specs
    SERVICE_AND_FRAMEWORKS.each do |service_and_framework|
      generate_controller_spec(
        service_and_framework,
        'sessions_controller_spec'
      )
    end
  end

  def self.generate_registrations_controller_specs
    SERVICE_AND_FRAMEWORKS.select { |service_and_framework| service_and_framework[:registration] }.each do |service_and_framework|
      generate_controller_spec(
        service_and_framework,
        'registrations_controller_spec'
      )
    end
  end

  def self.generate_passwords_controller_specs
    SERVICE_AND_FRAMEWORKS.each do |service_and_framework|
      generate_controller_spec(
        service_and_framework,
        'passwords_controller_spec'
      )
    end
  end

  def self.generate_users_controller_specs
    SERVICE_AND_FRAMEWORKS.each do |service_and_framework|
      generate_controller_spec(
        service_and_framework,
        'users_controller_spec'
      )
    end
  end

  def self.generate_controller_spec(service_and_framework, template_name)
    service_name = service_and_framework[:service_name]
    framework = service_and_framework[:framework]
    admin = service_and_framework[:admin]

    output_file_path = "spec/controllers/#{service_name}/#{framework.downcase}#{'/admin' if admin}/#{template_name}.rb"
    source_file_path = "data/spec_templates/#{template_name}.txt"

    tag_to_value = generate_tag_to_value(service_name, framework, admin)

    generate_spec_file(framework, output_file_path, source_file_path, tag_to_value, service_and_framework[:registration], service_and_framework[:admin])
  end

  REGISTRATION_ONLY_REGEX = %r{<registration_only>(.|\n)*?</registration_only>}
  ADMIN_ONLY_REGEX = %r{<admin_only>(.|\n)*?</admin_only>\n}
  NON_ADMIN_ONLY_REGEX = %r{<non_admin_only>(.|\n)*?</non_admin_only>\n}
  RM6187_ONLY_REGEX = %r{<rm6187_only>(.|\n)*?</rm6187_only>\n}

  SERVICE_AND_FRAMEWORKS = [
    {
      name: 'Legal services RM6240 user',
      service_name: 'legal_services',
      framework: 'RM6240',
      registration: true
    },
    {
      name: 'Legal services RM6240 admin',
      service_name: 'legal_services',
      framework: 'RM6240',
      admin: true
    },
    {
      name: 'Management consultancy RM6187 user',
      service_name: 'management_consultancy',
      framework: 'RM6187',
      registration: true,
    },
    {
      name: 'Management consultancy RM6187 admin',
      service_name: 'management_consultancy',
      framework: 'RM6187',
      admin: true
    },
    {
      name: 'Management consultancy RM6309 user',
      service_name: 'management_consultancy',
      framework: 'RM6309',
      registration: true
    },
    {
      name: 'Management consultancy RM6309 admin',
      service_name: 'management_consultancy',
      framework: 'RM6309',
      admin: true
    },
    {
      name: 'Supply teachers RM6238 user',
      service_name: 'supply_teachers',
      framework: 'RM6238',
    },
    {
      name: 'Supply teachers RM6238 admin',
      service_name: 'supply_teachers',
      framework: 'RM6238',
      admin: true
    },
  ].freeze
end
# rubocop:enable Metrics/ModuleLength

desc 'Generates the authentication specs'
task generate_authentication_specs: :environment do
  GenerateAuthenticationSpecs.generate_sessions_controller_specs
  GenerateAuthenticationSpecs.generate_registrations_controller_specs
  GenerateAuthenticationSpecs.generate_passwords_controller_specs
  GenerateAuthenticationSpecs.generate_users_controller_specs
end
