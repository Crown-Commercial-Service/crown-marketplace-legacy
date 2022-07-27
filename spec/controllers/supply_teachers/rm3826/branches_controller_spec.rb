require 'rails_helper'

RSpec.describe SupplyTeachers::RM3826::BranchesController, type: :controller do
  let(:default_params) { { service: 'supply_teachers', framework: framework } }
  let(:framework) { 'RM3826' }

  include_context 'and RM6238 is live in the future'

  describe 'GET index' do
    let(:first_branch) { create(:supply_teachers_rm3826_branch, :with_rates) }
    let(:second_branch) { create(:supply_teachers_rm3826_branch, :with_rates) }
    let(:branches) { [first_branch, second_branch] }

    context 'when not logged in' do
      it 'redirects to gateway page' do
        expect(get(:index)).to redirect_to(supply_teachers_rm3826_gateway_url)
      end
    end

    context 'when the framework is not the current framework' do
      login_st_buyer

      let(:framework) { 'RM6238' }

      it 'renders the unrecognised framework page with the right http status' do
        get :index

        expect(response).to render_template('supply_teachers/home/unrecognised_framework')
        expect(response).to have_http_status(:bad_request)
      end
    end

    shared_context 'and the postcode is valid' do
      let(:postcode) { 'SW1A 1AA' }

      before do
        allow(SupplyTeachers::RM3826::Branch).to receive(:search).and_return(branches)

        Geocoder::Lookup::Test.add_stub(
          postcode, [{ 'coordinates' => [51.5149666, -0.119098] }]
        )
        get :index, params: params
      end

      after do
        Geocoder::Lookup::Test.reset
      end

      it 'assigns BranchSearchResults to @branches' do
        expect(assigns(:branches).map(&:class).uniq).to eq(
          [SupplyTeachers::BranchSearchResult]
        )
      end

      it 'expects branches to be assigned to @branches' do
        expect(assigns(:branches).map(&:name))
          .to eq([first_branch.name, second_branch.name])
      end

      context 'when no radius is specified' do
        it 'assigns radius_in_miles to the default radius' do
          expect(assigns(:radius_in_miles)).to eq(25)
        end
      end

      context 'when a radius is specified' do
        let(:params) { super().merge(radius: '5') }

        it 'assigns radius_in_miles to the given radius' do
          expect(assigns(:radius_in_miles)).to eq(5)
        end
      end

      it 'responds to html' do
        expect(response.media_type).to eq 'text/html'
      end

      it 'responds to requests for spreadsheets' do
        allow(SupplyTeachers::Spreadsheet)
          .to receive(:new)
          .and_return(instance_double('Spreadsheet', to_xlsx: 'spreadsheet-data'))

        get :index, params: params.merge(format: 'xlsx')

        expect(response.media_type)
          .to eq 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
      end
    end

    shared_context 'and the postcode is nil' do
      let(:postcode) { nil }

      before { get :index, params: params }
    end

    shared_context 'and the postcode is invalid' do
      let(:postcode) { valid_fake_postcode }

      before do
        Geocoder::Lookup::Test.add_stub(
          postcode, [{ 'coordinates' => nil }]
        )
        get :index, params: params
      end

      after do
        Geocoder::Lookup::Test.reset
      end
    end

    context 'and these are the results for nominated worker' do
      login_st_buyer

      let(:params) do
        {
          journey: 'supply-teachers',
          slug: 'nominated-worker-results',
          looking_for: 'worker',
          worker_type: 'nominated',
          postcode: postcode
        }
      end

      context 'when the postcode is valid' do
        include_context 'and the postcode is valid'

        it 'assigns back_path to school-postcode-nominated-worker question path' do
          expect(assigns(:back_path)).to eq(
            journey_question_path(params.merge(slug: 'school-postcode-nominated-worker'))
          )
        end
      end

      context 'when postcode parsing fails' do
        include_context 'and the postcode is nil'

        it 'renders school-postcode-nominated-worker question' do
          expect(response).to render_template('journey/school_postcode_nominated_worker')
        end
      end

      context 'when postcode geocoding fails' do
        include_context 'and the postcode is invalid'

        it 'renders school-postcode-nominated-worker question' do
          expect(response).to render_template('journey/school_postcode_nominated_worker')
        end
      end
    end

    context 'and these are the results for fixed term' do
      login_st_buyer

      let(:params) do
        {
          journey: 'supply-teachers',
          slug: 'fixed-term-results',
          looking_for: 'worker',
          worker_type: 'agency_supplied',
          payroll_provider: 'school',
          contract_end_date_day: '1',
          contract_end_date_month: '2',
          contract_end_date_year: '2022',
          contract_start_date_day: '1',
          contract_start_date_month: '1',
          contract_start_date_year: '2021',
          salary: '1234',
          postcode: postcode
        }
      end

      context 'when the postcode is valid' do
        include_context 'and the postcode is valid'

        it 'assigns back_path to school-postcode-agency-supplied-worker question path' do
          expect(assigns(:back_path)).to eq(
            journey_question_path(params.merge(slug: 'school-postcode-agency-supplied-worker'))
          )
        end

        context 'when an AJAX request is made' do
          before { get :index, params: params.merge(annual_salary: { first_branch.id => annual_salary }), xhr: true }

          let(:annual_salary) { '500' }

          it 'responds with the correct content type' do
            expect(response.media_type).to eq 'text/javascript'
          end

          it 'returns the first matching branch' do
            expect(JSON.parse(response.body)).to include(
              'id' => first_branch.id
            )
          end

          context 'when no daily rate is provided' do
            let(:annual_salary) { '' }

            it 'returns nothing' do
              expect(JSON.parse(response.body)).to be_nil
            end
          end
        end
      end

      context 'when postcode parsing fails' do
        include_context 'and the postcode is nil'

        it 'renders school-postcode-agency-supplied-worker question' do
          expect(response).to render_template('journey/school_postcode_agency_supplied_worker')
        end
      end

      context 'when postcode geocoding fails' do
        include_context 'and the postcode is invalid'

        it 'renders school-postcode-agency-supplied-worker question' do
          expect(response).to render_template('journey/school_postcode_agency_supplied_worker')
        end
      end
    end

    context 'and these are the results for agency payroll' do
      login_st_buyer

      let(:params) do
        {
          journey: 'supply-teachers',
          slug: 'agency-payroll-results',
          looking_for: 'worker',
          worker_type: 'agency_supplied',
          payroll_provider: 'agency',
          job_type: 'qt',
          term: '0_1',
          postcode: postcode
        }
      end

      context 'when the postcode is valid' do
        include_context 'and the postcode is valid'

        it 'assigns back_path to agency-payroll question path' do
          expect(assigns(:back_path)).to eq(
            journey_question_path(params.merge(slug: 'agency-payroll'))
          )
        end
      end

      context 'when postcode parsing fails' do
        include_context 'and the postcode is nil'

        it 'renders agency-payroll question' do
          expect(response).to render_template('journey/agency_payroll')
        end
      end

      context 'when postcode geocoding fails' do
        include_context 'and the postcode is invalid'

        it 'renders agency-payroll question' do
          expect(response).to render_template('journey/agency_payroll')
        end
      end
    end
  end

  describe 'GET show' do
    login_st_buyer

    let(:branch) { create(:supply_teachers_rm3826_branch, :with_rates) }

    before { get :show, params: { id: branch.slug } }

    it 'renders the show page' do
      expect(response).to render_template(:show)
    end

    it 'sets the back path' do
      expect(assigns(:back_path)).to eq :back
    end

    it 'sets the right branch' do
      expect(assigns(:branch)).to eq branch
    end
  end
end
