require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '#page_title' do
    context 'when there is no prefix' do
      it 'returns title stored in locale file' do
        expect(helper.page_title).to eq(t('layouts.application.title'))
      end
    end

    context 'when optional prefix is nil' do
      before do
        allow(helper).to receive(:content_for).with(anything).and_return(nil)
        allow(helper).to receive(:content_for).with(:page_title_prefix).and_return(nil)
      end

      it 'returns title stored in locale file' do
        expect(helper.page_title).to eq(t('layouts.application.title'))
      end
    end

    context 'when optional prefix is an empty string' do
      before do
        allow(helper).to receive(:content_for).with(anything).and_return(nil)
        allow(helper).to receive(:content_for).with(:page_title_prefix).and_return('')
      end

      it 'returns title stored in locale file' do
        expect(helper.page_title).to eq(t('layouts.application.title'))
      end
    end

    context 'when optional prefix contains a newline' do
      before do
        allow(helper).to receive(:content_for).with(anything).and_return(nil)
        allow(helper).to receive(:content_for).with(:page_title_prefix).and_return("Error\n")
      end

      it 'returns title stored in locale file with prefix' do
        expected_title = "Error: #{t('layouts.application.title')}"
        expect(helper.page_title).to eq(expected_title)
      end
    end

    context 'when optional prefix is set' do
      before do
        allow(helper).to receive(:content_for).with(anything).and_return(nil)
        allow(helper).to receive(:content_for).with(:page_title_prefix).and_return('Error')
      end

      it 'returns title stored in locale file with prefix' do
        expected_title = "Error: #{t('layouts.application.title')}"
        expect(helper.page_title).to eq(expected_title)
      end
    end

    context 'when page_title and page_section are set' do
      before do
        allow(helper).to receive(:content_for).with(:page_title).and_return('page')
        allow(helper).to receive(:content_for).with(:page_section).and_return('section')
        allow(helper).to receive(:content_for).with(:page_title_prefix).and_return('prefix')
      end

      it 'returns fields joined by semi-colons' do
        expected_title = "prefix: page: section: #{t('layouts.application.title')}"
        expect(helper.page_title).to eq(expected_title)
      end
    end
  end

  describe '#hidden_fields_for_previous_steps_and_responses' do
    context 'when there are multiple previous questions and answers' do
      let(:questions_and_answers) do
        {
          'question-1' => 'answer-1',
          'question-2' => 'answer-2'
        }
      end
      let(:journey) { instance_double('Journey', previous_questions_and_answers: questions_and_answers) }
      let(:html) { helper.hidden_fields_for_previous_steps_and_responses(journey) }

      it 'renders hidden field for question 1' do
        expect(html).to have_css('input[type="hidden"][name="question-1"][value="answer-1"]', visible: :hidden)
      end

      it 'renders hidden field for question 2' do
        expect(html).to have_css('input[type="hidden"][name="question-2"][value="answer-2"]', visible: :hidden)
      end
    end
  end

  describe '#miles_to_meters' do
    it 'returns the distance in miles in meters' do
      miles = 10
      expected = DistanceConverter.miles_to_metres(miles)
      expect(helper.miles_to_metres(miles)).to eq(expected)
    end
  end

  describe '#url_formatter' do
    context 'with a url that is missing the protocol' do
      it 'returns the url with a http protocol' do
        url = 'www.example.com'

        expect(helper.url_formatter(url)).to eq('http://www.example.com')
      end
    end

    context 'with a url that is not missing the protocol' do
      it 'returns the provided url' do
        url = 'https://www.example.com'

        expect(helper.url_formatter(url)).to eq('https://www.example.com')
      end
    end
  end

  describe '.contact_link' do
    let(:result) { helper.contact_link(link_text) }
    let(:link_text) { 'Contact us' }

    before { helper.params[:service] = service }

    context 'when the service param is management_consultancy' do
      let(:service) { 'management_consultancy' }

      it 'returns the correct link with text' do
        expect(result).to eq '<a target="blank" class="govuk-link" href="https://www.crowncommercial.gov.uk/contact?service=Management+Consultancy">Contact us</a>'
      end
    end

    context 'when the service param is management_consultancy/admin' do
      let(:service) { 'management_consultancy/admin' }

      it 'returns the correct link with text' do
        expect(result).to eq '<a target="blank" class="govuk-link" href="https://www.crowncommercial.gov.uk/contact?service=Management+Consultancy">Contact us</a>'
      end
    end

    context 'when the service param is legal_services' do
      let(:service) { 'legal_services' }

      it 'returns the correct link with text' do
        expect(result).to eq '<a target="blank" class="govuk-link" href="https://www.crowncommercial.gov.uk/contact?service=Legal+Services">Contact us</a>'
      end
    end

    context 'when the service param is legal_services/admin' do
      let(:service) { 'legal_services/admin' }

      it 'returns the correct link with text' do
        expect(result).to eq '<a target="blank" class="govuk-link" href="https://www.crowncommercial.gov.uk/contact?service=Legal+Services">Contact us</a>'
      end
    end

    context 'when the service param is supply_teachers' do
      let(:service) { 'supply_teachers' }

      it 'returns the correct link with text' do
        expect(result).to eq '<a target="blank" class="govuk-link" href="https://www.crowncommercial.gov.uk/contact?service=Supply+Teachers">Contact us</a>'
      end
    end

    context 'when the service param is supply_teachers/admin' do
      let(:service) { 'supply_teachers/admin' }

      it 'returns the correct link with text' do
        expect(result).to eq '<a target="blank" class="govuk-link" href="https://www.crowncommercial.gov.uk/contact?service=Supply+Teachers">Contact us</a>'
      end
    end

    context 'when the service param is auth' do
      let(:service) { 'auth' }

      it 'returns the correct link with text' do
        expect(result).to eq '<a target="blank" class="govuk-link" href="https://www.crowncommercial.gov.uk/contact?service=Supply+Teachers">Contact us</a>'
      end
    end
  end

  describe '#format_money' do
    context 'when no value is passed for precision' do
      let(:result) { helper.format_money(123456.123456) }

      it 'returns the cost to 2 dp' do
        expect(result).to eq '£123,456.12'
      end
    end

    context 'when a value is passed for precision' do
      let(:result) { helper.format_money(123456.123456, precision) }

      context 'and that value is 0' do
        let(:precision) { 0 }

        it 'returns the cost to 0 dp' do
          expect(result).to eq '£123,456'
        end
      end

      context 'and that value is 2' do
        let(:precision) { 2 }

        it 'returns the cost to 2 dp' do
          expect(result).to eq '£123,456.12'
        end
      end

      context 'and that value is 4' do
        let(:precision) { 4 }

        it 'returns the cost to 4 dp' do
          expect(result).to eq '£123,456.1235'
        end
      end
    end
  end

  describe '#checked?' do
    let(:checked) { helper.checked?(actual, expected) }

    context 'when expected is yes' do
      let(:expected) { 'yes' }

      context 'and actual is also yes' do
        let(:actual) { 'yes' }

        it 'returns truthy' do
          expect(checked).to be_truthy
        end
      end

      context 'and actual is no' do
        let(:actual) { 'no' }

        it 'returns falsey' do
          expect(checked).to be_falsey
        end
      end

      context 'and actual is nil' do
        let(:actual) { nil }

        it 'returns falsey' do
          expect(checked).to be_falsey
        end
      end
    end

    context 'when expected is no' do
      let(:expected) { 'no' }

      context 'and actual is yes' do
        let(:actual) { 'yes' }

        it 'returns falsey' do
          expect(checked).to be_falsey
        end
      end

      context 'and actual is also no' do
        let(:actual) { 'no' }

        it 'returns truthy' do
          expect(checked).to be_truthy
        end
      end

      context 'and actual is nil' do
        let(:actual) { nil }

        it 'returns falsey' do
          expect(checked).to be_falsey
        end
      end
    end
  end

  describe '.cookie_preferences_settings' do
    let(:result) { helper.cookie_preferences_settings }
    let(:default_cookie_settings) do
      {
        'settings_viewed' => false,
        'google_analytics_enabled' => false,
        'glassbox_enabled' => false
      }
    end

    context 'when the cookie has not been set' do
      it 'returns the default settings' do
        expect(result).to eq(default_cookie_settings)
      end
    end

    context 'when the cookie has been set' do
      before { helper.request.cookies['crown_marketplace_cookie_options_v1'] = cookie_settings }

      context 'and it is a hash' do
        let(:expected_cookie_settings) do
          {
            'settings_viewed' => true,
            'google_analytics_enabled' => true,
            'glassbox_enabled' => false
          }
        end
        let(:cookie_settings) { expected_cookie_settings.to_json }

        it 'returns the settings from the cookie' do
          expect(result).to eq(expected_cookie_settings)
        end
      end

      context 'and it is not a hash' do
        let(:cookie_settings) { '123' }

        it 'returns the default settings' do
          expect(result).to eq(default_cookie_settings)
        end
      end
    end
  end

  describe 'admin upload methods' do
    let(:upload) do
      admin_upload = build(:supply_teachers_rm6238_admin_upload)
      admin_upload.update(current_accredited_suppliers: create_file(*FILE_PARAMS[:valid_xlsx]))
      admin_upload.update(master_vendor_contacts: create_file(*FILE_PARAMS[:valid_csv]))
      admin_upload
    end

    let(:created_files) { [] }

    def create_file(extension, content)
      temp_file = Tempfile.new(['supplier_data', ".#{extension}"])
      created_files << temp_file

      fixture_file_upload(temp_file.path, content)
    end

    after { created_files.each(&:unlink) }

    context 'when considering admin_upload_file' do
      it 'the path has the expected params' do
        uri_params = CGI.parse(URI.parse(helper.admin_upload_file(upload, upload.current_accredited_suppliers, :st, 'RM6238')).query)

        expect(uri_params).to eq({
                                   'disposition' => ['attachment'],
                                   'key' => ['st_RM6238_upload_id'],
                                   'value' => [upload.id],
                                   'format' => ['xlsx']
                                 })
      end
    end

    context 'when considering get_file_extension' do
      it 'returns xlsx for current_accredited_suppliers' do
        expect(helper.get_file_extension(upload.current_accredited_suppliers)).to eq :xlsx
      end

      it 'returns csv for master_vendor_contacts' do
        expect(helper.get_file_extension(upload.master_vendor_contacts)).to eq :csv
      end
    end
  end

  describe 'admin upload methods' do
    let(:upload) do
      admin_upload = build(:supply_teachers_rm6238_admin_upload)
      admin_upload.update(current_accredited_suppliers: create_file(*FILE_PARAMS[:valid_xlsx]))
      admin_upload.update(master_vendor_contacts: create_file(*FILE_PARAMS[:valid_csv]))
      admin_upload
    end

    let(:created_files) { [] }

    def create_file(extension, content)
      temp_file = Tempfile.new(['supplier_data', ".#{extension}"])
      created_files << temp_file

      fixture_file_upload(temp_file.path, content)
    end

    after { created_files.each(&:unlink) }

    context 'when considering admin_upload_file' do
      it 'the path has the expected params' do
        uri_params = CGI.parse(URI.parse(helper.admin_upload_file(upload, upload.current_accredited_suppliers, :st, 'RM6238')).query)

        expect(uri_params).to eq({
                                   'disposition' => ['attachment'],
                                   'key' => ['st_RM6238_upload_id'],
                                   'value' => [upload.id],
                                   'format' => ['xlsx']
                                 })
      end
    end

    context 'when considering get_file_extension' do
      it 'returns xlsx for current_accredited_suppliers' do
        expect(helper.get_file_extension(upload.current_accredited_suppliers)).to eq :xlsx
      end

      it 'returns csv for master_vendor_contacts' do
        expect(helper.get_file_extension(upload.master_vendor_contacts)).to eq :csv
      end
    end
  end
end
