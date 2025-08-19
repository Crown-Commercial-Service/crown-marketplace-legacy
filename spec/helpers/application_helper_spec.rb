require 'rails_helper'

RSpec.describe ApplicationHelper do
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

  describe '#breadcrumbs' do
    context 'when there is nothing given' do
      it 'returns nil' do
        expect(helper.breadcrumbs).to be_nil
      end
    end

    context 'when centent is provided' do
      before { allow(helper).to receive(:content_for).with(:breadcrumbs).and_return('Something') }

      it 'returns the content' do
        expect(helper.breadcrumbs).to eq('Something')
      end
    end
  end

  describe '#admin_breadcrumbs' do
    before { allow(helper).to receive(:service_path_base).and_return('/admin') }

    context 'when nothing is provided' do
      before { helper.admin_breadcrumbs }

      it 'sets the html for breadcrumbs' do
        expect(helper.breadcrumbs).to eq(
          '<nav class="govuk-breadcrumbs" aria-label="Breadcrumb">
            <ol class="govuk-breadcrumbs__list">
              <li class="govuk-breadcrumbs__list-item">
                <a class="govuk-breadcrumbs__link" href="/admin">Admin dashboard</a>
              </li>
            </ol>
          </nav>'.gsub(/\s{2,}/, '').gsub("\n", '')
        )
      end
    end

    context 'when breadcrumbs are provided' do
      before { helper.admin_breadcrumbs({ text: 'Elma', href: '/elma' }) }

      # rubocop:disable RSpec/ExampleLength
      it 'sets the html for breadcrumbs' do
        expect(helper.breadcrumbs).to eq(
          '<nav class="govuk-breadcrumbs" aria-label="Breadcrumb">
            <ol class="govuk-breadcrumbs__list">
              <li class="govuk-breadcrumbs__list-item">
                <a class="govuk-breadcrumbs__link" href="/admin">Admin dashboard</a>
              </li>
              <li class="govuk-breadcrumbs__list-item">
                <a class="govuk-breadcrumbs__link" href="/elma">Elma</a>
              </li>
            </ol>
          </nav>'.gsub(/\s{2,}/, '').gsub("\n", '')
        )
      end
      # rubocop:enable RSpec/ExampleLength
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
      let(:journey) { instance_double(GenericJourney, previous_questions_and_answers: questions_and_answers) }
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
        expect(result).to eq '<a target="blank" class="govuk-link" rel="noreferrer noopener" href="https://www.crowncommercial.gov.uk/contact?service=Management+Consultancy">Contact us</a>'
      end
    end

    context 'when the service param is management_consultancy/admin' do
      let(:service) { 'management_consultancy/admin' }

      it 'returns the correct link with text' do
        expect(result).to eq '<a target="blank" class="govuk-link" rel="noreferrer noopener" href="https://www.crowncommercial.gov.uk/contact?service=Management+Consultancy">Contact us</a>'
      end
    end

    context 'when the service param is legal_services' do
      let(:service) { 'legal_services' }

      it 'returns the correct link with text' do
        expect(result).to eq '<a target="blank" class="govuk-link" rel="noreferrer noopener" href="https://www.crowncommercial.gov.uk/contact?service=Legal+Services">Contact us</a>'
      end
    end

    context 'when the service param is legal_services/admin' do
      let(:service) { 'legal_services/admin' }

      it 'returns the correct link with text' do
        expect(result).to eq '<a target="blank" class="govuk-link" rel="noreferrer noopener" href="https://www.crowncommercial.gov.uk/contact?service=Legal+Services">Contact us</a>'
      end
    end

    context 'when the service param is legal_panel_for_government' do
      let(:service) { 'legal_panel_for_government' }

      it 'returns the correct link with text' do
        expect(result).to eq '<a target="blank" class="govuk-link" rel="noreferrer noopener" href="https://www.crowncommercial.gov.uk/contact?service=Legal+Panel+for+Government">Contact us</a>'
      end
    end

    context 'when the service param is legal_panel_for_government/admin' do
      let(:service) { 'legal_panel_for_government/admin' }

      it 'returns the correct link with text' do
        expect(result).to eq '<a target="blank" class="govuk-link" rel="noreferrer noopener" href="https://www.crowncommercial.gov.uk/contact?service=Legal+Panel+for+Government">Contact us</a>'
      end
    end

    context 'when the service param is supply_teachers' do
      let(:service) { 'supply_teachers' }

      it 'returns the correct link with text' do
        expect(result).to eq '<a target="blank" class="govuk-link" rel="noreferrer noopener" href="https://www.crowncommercial.gov.uk/contact?service=Supply+Teachers">Contact us</a>'
      end
    end

    context 'when the service param is supply_teachers/admin' do
      let(:service) { 'supply_teachers/admin' }

      it 'returns the correct link with text' do
        expect(result).to eq '<a target="blank" class="govuk-link" rel="noreferrer noopener" href="https://www.crowncommercial.gov.uk/contact?service=Supply+Teachers">Contact us</a>'
      end
    end

    context 'when the service param is auth' do
      let(:service) { 'auth' }

      it 'returns the correct link with text' do
        expect(result).to eq '<a target="blank" class="govuk-link" rel="noreferrer noopener" href="https://www.crowncommercial.gov.uk/contact?service=Supply+Teachers">Contact us</a>'
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
        'usage' => false,
        'glassbox' => false
      }
    end

    context 'when the cookie has not been set' do
      it 'returns the default settings' do
        expect(result).to eq(default_cookie_settings)
      end
    end

    context 'when the cookie has been set' do
      before { helper.request.cookies['cookie_preferences_cmp'] = cookie_settings }

      context 'and it is a hash' do
        let(:expected_cookie_settings) do
          {
            'settings_viewed' => true,
            'usage' => true,
            'glassbox' => false
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

  # rubocop:disable RSpec/ExampleLength
  describe '#pagination_params' do
    let(:result) { pagination_params(paginator) }

    let(:paginator) { Kaminari::Helpers::Paginator.new(template, **options) }
    let(:template) { Object.new }
    let(:options) do
      {
        current_page: current_page_number,
        per_page: 25,
        window: 2,
        left: 1,
        right: 1,
        remote: false,
        views_prefix: 'shared',
        total_pages: total_pages_number
      }
    end
    let(:total_pages_number) { 5 }

    before do
      allow(template).to receive(:render)
      allow(template).to receive(:url_for) do |hash|
        "/crown-marketplace?page=#{hash[:page]}"
      end
      allow(template).to receive_messages(params: {}, options: {}, link_to: "<a href='#'>link</a>", output_buffer: ActionView::OutputBuffer.new)
    end

    context 'when the current page is the first page' do
      let(:current_page_number) { 1 }

      context 'and there are multiple pages' do
        it 'has the items and the next link, all with the right values' do
          expect(result).to eq(
            {
              pagination_items: [
                { type: :number, href: '/crown-marketplace?page=', number: 1, current: true },
                { type: :number, href: '/crown-marketplace?page=2', number: 2, current: false },
                { type: :number, href: '/crown-marketplace?page=3', number: 3, current: false },
                { type: :number, href: '/crown-marketplace?page=4', number: 4, current: false },
                { type: :number, href: '/crown-marketplace?page=5', number: 5, current: false }
              ],
              pagination_next: { href: '/crown-marketplace?page=2' }
            }
          )
        end
      end

      context 'and there are multiple pages with ellipsis' do
        let(:total_pages_number) { 12 }

        it 'has the items with an ellipsis and the next link, all with the right values' do
          expect(result).to eq(
            {
              pagination_items: [
                { type: :number, href: '/crown-marketplace?page=', number: 1, current: true },
                { type: :number, href: '/crown-marketplace?page=2', number: 2, current: false },
                { type: :number, href: '/crown-marketplace?page=3', number: 3, current: false },
                { ellipsis: true },
                { type: :number, href: '/crown-marketplace?page=12', number: 12, current: false }
              ],
              pagination_next: { href: '/crown-marketplace?page=2' }
            }
          )
        end
      end
    end

    context 'when the current page is a middle page' do
      context 'and there are multiple pages' do
        let(:current_page_number) { 3 }

        it 'has the previous link, items and the next link, all with the right values' do
          expect(result).to eq(
            {
              pagination_previous: { href: '/crown-marketplace?page=2' },
              pagination_items: [
                { type: :number, href: '/crown-marketplace?page=', number: 1, current: false },
                { type: :number, href: '/crown-marketplace?page=2', number: 2, current: false },
                { type: :number, href: '/crown-marketplace?page=3', number: 3, current: true },
                { type: :number, href: '/crown-marketplace?page=4', number: 4, current: false },
                { type: :number, href: '/crown-marketplace?page=5', number: 5, current: false }
              ],
              pagination_next: { href: '/crown-marketplace?page=4' }
            }
          )
        end
      end

      context 'and there are multiple pages with ellipsis' do
        let(:current_page_number) { 6 }
        let(:total_pages_number) { 12 }

        it 'has the previous link, items with ellipsis and the next link, all with the right values' do
          expect(result).to eq(
            {
              pagination_previous: { href: '/crown-marketplace?page=5' },
              pagination_items: [
                { type: :number, href: '/crown-marketplace?page=', number: 1, current: false },
                { ellipsis: true },
                { type: :number, href: '/crown-marketplace?page=4', number: 4, current: false },
                { type: :number, href: '/crown-marketplace?page=5', number: 5, current: false },
                { type: :number, href: '/crown-marketplace?page=6', number: 6, current: true },
                { type: :number, href: '/crown-marketplace?page=7', number: 7, current: false },
                { type: :number, href: '/crown-marketplace?page=8', number: 8, current: false },
                { ellipsis: true },
                { type: :number, href: '/crown-marketplace?page=12', number: 12, current: false }
              ],
              pagination_next: { href: '/crown-marketplace?page=7' }
            }
          )
        end
      end
    end

    context 'when the current page is the last page' do
      context 'and there are multiple pages' do
        let(:current_page_number) { 5 }

        it 'has the previous link and the items, all with the right values' do
          expect(result).to eq(
            {
              pagination_previous: { href: '/crown-marketplace?page=4' },
              pagination_items: [
                { type: :number, href: '/crown-marketplace?page=', number: 1, current: false },
                { type: :number, href: '/crown-marketplace?page=2', number: 2, current: false },
                { type: :number, href: '/crown-marketplace?page=3', number: 3, current: false },
                { type: :number, href: '/crown-marketplace?page=4', number: 4, current: false },
                { type: :number, href: '/crown-marketplace?page=5', number: 5, current: true }
              ]
            }
          )
        end
      end

      context 'and there are multiple pages with ellipsis' do
        let(:current_page_number) { 12 }
        let(:total_pages_number) { 12 }

        it 'has the previous link and the items with an ellipsis, all with the right values' do
          expect(result).to eq(
            {
              pagination_previous: { href: '/crown-marketplace?page=11' },
              pagination_items: [
                { type: :number, href: '/crown-marketplace?page=', number: 1, current: false },
                { ellipsis: true },
                { type: :number, href: '/crown-marketplace?page=10', number: 10, current: false },
                { type: :number, href: '/crown-marketplace?page=11', number: 11, current: false },
                { type: :number, href: '/crown-marketplace?page=12', number: 12, current: true }
              ]
            }
          )
        end
      end
    end
  end
  # rubocop:enable RSpec/ExampleLength
end
