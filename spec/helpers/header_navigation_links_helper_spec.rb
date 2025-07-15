require 'rails_helper'

RSpec.describe HeaderNavigationLinksHelper do
  let(:service_path_base) { '/crown-marketplace-legacy' }

  describe '#service_name_text' do
    let(:result) { helper.service_name_text }

    before { helper.params[:service] = service }

    context 'when the service is legal_services' do
      let(:service) { 'legal_services' }

      it 'returns Find legal service for the wider public sector' do
        expect(result).to eq('Find legal service for the wider public sector')
      end
    end

    context 'when the service is legal_services/admin' do
      let(:service) { 'legal_services/admin' }

      it 'returns Crown Marketplace' do
        expect(result).to eq('Crown Marketplace')
      end
    end

    context 'when the service is legal_panel_for_government' do
      let(:service) { 'legal_panel_for_government' }

      it 'returns Find legal service for the wider public sector' do
        expect(result).to eq('Find legal service for government')
      end
    end

    context 'when the service is legal_panel_for_government/admin' do
      let(:service) { 'legal_panel_for_government/admin' }

      it 'returns Crown Marketplace' do
        expect(result).to eq('Crown Marketplace')
      end
    end

    context 'when the service is management_consultancy' do
      let(:service) { 'management_consultancy' }

      it 'returns Find management consultancy services' do
        expect(result).to eq('Find management consultancy services')
      end
    end

    context 'when the service is management_consultancy/admin' do
      let(:service) { 'management_consultancy/admin' }

      it 'returns Crown Marketplace' do
        expect(result).to eq('Crown Marketplace')
      end
    end

    context 'when the service is supply_teachers' do
      let(:service) { 'supply_teachers' }

      it 'returns Find supply teachers and agency workers' do
        expect(result).to eq('Find supply teachers and agency workers')
      end
    end

    context 'when the service is supply_teachers/admin' do
      let(:service) { 'supply_teachers/admin' }

      it 'returns Crown Marketplace' do
        expect(result).to eq('Crown Marketplace')
      end
    end
  end

  describe '#service_authentication_links' do
    let(:result) { helper.service_authentication_links }

    before do
      helper.params[:service] = service
      allow(helper).to receive(:service_path_base).and_return(service_path_base)
    end

    context 'when signed in' do
      before { allow(helper).to receive(:user_signed_in?).and_return(true) }

      context 'when the service is legal_services' do
        let(:service) { 'legal_services' }

        it 'returns the sign out link with the right options' do
          expect(result).to eq(
            [
              { text: 'Sign out', href: '/crown-marketplace-legacy/sign-out', method: :delete }
            ]
          )
        end
      end

      context 'when the service is legal_services/admin' do
        let(:service) { 'legal_services/admin' }

        it 'returns the sign out link with the right options' do
          expect(result).to eq(
            [
              { text: 'Sign out', href: '/crown-marketplace-legacy/sign-out', method: :delete }
            ]
          )
        end
      end

      context 'when the service is legal_panel_for_government' do
        let(:service) { 'legal_panel_for_government' }

        it 'returns the sign out link with the right options' do
          expect(result).to eq(
            [
              { text: 'Sign out', href: '/crown-marketplace-legacy/sign-out', method: :delete }
            ]
          )
        end
      end

      context 'when the service is legal_panel_for_government/admin' do
        let(:service) { 'legal_panel_for_government/admin' }

        it 'returns the sign out link with the right options' do
          expect(result).to eq(
            [
              { text: 'Sign out', href: '/crown-marketplace-legacy/sign-out', method: :delete }
            ]
          )
        end
      end

      context 'when the service is management_consultancy' do
        let(:service) { 'management_consultancy' }

        it 'returns the sign out link with the right options' do
          expect(result).to eq(
            [
              { text: 'Sign out', href: '/crown-marketplace-legacy/sign-out', method: :delete }
            ]
          )
        end
      end

      context 'when the service is management_consultancy/admin' do
        let(:service) { 'management_consultancy/admin' }

        it 'returns the sign out link with the right options' do
          expect(result).to eq(
            [
              { text: 'Sign out', href: '/crown-marketplace-legacy/sign-out', method: :delete }
            ]
          )
        end
      end

      context 'when the service is supply_teachers' do
        let(:service) { 'supply_teachers' }

        it 'returns the sign out link with the right options' do
          expect(result).to eq(
            [
              { text: 'Sign out', href: '/crown-marketplace-legacy/sign-out', method: :delete }
            ]
          )
        end
      end

      context 'when the service is supply_teachers/admin' do
        let(:service) { 'supply_teachers/admin' }

        it 'returns the sign out link with the right options' do
          expect(result).to eq(
            [
              { text: 'Sign out', href: '/crown-marketplace-legacy/sign-out', method: :delete }
            ]
          )
        end
      end
    end

    context 'when signed out' do
      before { allow(helper).to receive(:user_signed_in?).and_return(false) }

      context 'when the service is legal_services' do
        let(:service) { 'legal_services' }

        it 'returns the create account and sign in link' do
          expect(result).to eq(
            [
              { text: 'Create an account', href: '/crown-marketplace-legacy/sign-up' },
              { text: 'Sign in', href: '/crown-marketplace-legacy/sign-in' }
            ]
          )
        end
      end

      context 'when the service is legal_services/admin' do
        let(:service) { 'legal_services/admin' }

        it 'returns the sign in link' do
          expect(result).to eq(
            [
              { text: 'Sign in', href: '/crown-marketplace-legacy/sign-in' }
            ]
          )
        end
      end

      context 'when the service is legal_panel_for_government' do
        let(:service) { 'legal_panel_for_government' }

        it 'returns the create account and sign in link' do
          expect(result).to eq(
            [
              { text: 'Create an account', href: '/crown-marketplace-legacy/sign-up' },
              { text: 'Sign in', href: '/crown-marketplace-legacy/sign-in' }
            ]
          )
        end
      end

      context 'when the service is legal_panel_for_government/admin' do
        let(:service) { 'legal_panel_for_government/admin' }

        it 'returns the sign in link' do
          expect(result).to eq(
            [
              { text: 'Sign in', href: '/crown-marketplace-legacy/sign-in' }
            ]
          )
        end
      end

      context 'when the service is management_consultancy' do
        let(:service) { 'management_consultancy' }

        it 'returns the create account and sign in link' do
          expect(result).to eq(
            [
              { text: 'Create an account', href: '/crown-marketplace-legacy/sign-up' },
              { text: 'Sign in', href: '/crown-marketplace-legacy/sign-in' }
            ]
          )
        end
      end

      context 'when the service is management_consultancy/admin' do
        let(:service) { 'management_consultancy/admin' }

        it 'returns the sign in link' do
          expect(result).to eq(
            [
              { text: 'Sign in', href: '/crown-marketplace-legacy/sign-in' }
            ]
          )
        end
      end

      context 'when the service is supply_teachers' do
        let(:service) { 'supply_teachers' }

        it 'returns the gateway link' do
          expect(result).to eq(
            [
              { text: 'Sign in', href: '/crown-marketplace-legacy/gateway' }
            ]
          )
        end
      end

      context 'when the service is supply_teachers/admin' do
        let(:service) { 'supply_teachers/admin' }

        it 'returns the sign in link' do
          expect(result).to eq(
            [
              { text: 'Sign in', href: '/crown-marketplace-legacy/sign-in' }
            ]
          )
        end
      end
    end
  end

  describe '#service_navigation_links' do
    let(:result) { helper.service_navigation_links }
    let(:user_signed_in) { true }

    before do
      allow(helper).to receive_messages(user_signed_in?: user_signed_in, service_path_base: service_path_base)
      allow(helper).to receive(:current_page?).with(service_path_base).and_return(is_current_page)
    end

    context 'when the current path is not the same as service path base' do
      let(:is_current_page) { false }

      it 'returns the back to start link with the active false' do
        expect(result).to eq(
          [
            { text: 'Back to start', href: '/crown-marketplace-legacy', active: false }
          ]
        )
      end
    end

    context 'when the current path is the same as service path base' do
      let(:is_current_page) { true }

      it 'returns the back to start link with the active true' do
        expect(result).to eq(
          [
            { text: 'Back to start', href: '/crown-marketplace-legacy', active: true }
          ]
        )
      end
    end

    context 'when the service is management consultancy' do
      let(:is_current_page_2) { false }

      before do
        helper.params[:service] = 'management_consultancy'
        helper.params[:framework] = 'RM6309'

        allow(helper).to receive(:current_page?).with('/management-consultancy/RM6309/choose-lot').and_return(is_current_page)
      end

      # rubocop:disable RSpec/NestedGroups
      context 'when the user is signed in' do
        context 'when the current path is not the same as start base' do
          let(:is_current_page) { false }

          it 'returns the back to start link with the active false' do
            expect(result).to eq(
              [
                { text: 'Back to start', href: '/management-consultancy/RM6309/start', active: false }
              ]
            )
          end
        end

        context 'when the current path is not the same as start base but is the service start page' do
          let(:is_current_page) { true }

          it 'returns the back to start link with the active true' do
            expect(result).to eq(
              [
                { text: 'Back to start', href: '/management-consultancy/RM6309/start', active: true }
              ]
            )
          end
        end
      end
      # rubocop:enable RSpec/NestedGroups

      context 'when the user is not signed in' do
        let(:user_signed_in) { false }
        let(:is_current_page) { false }

        it 'returns the back to start link with the active false' do
          expect(result).to eq(
            [
              { text: 'Back to start', href: '/crown-marketplace-legacy', active: false }
            ]
          )
        end
      end
    end
  end
end
