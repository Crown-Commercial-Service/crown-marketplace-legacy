require 'rails_helper'

RSpec.describe ActiveStorage::BlobsController, type: :controller do
  let(:default_params) do
    {
      signed_id: signed_id,
      filename: filename,
      disposition: 'attachment',
      key: object_id_key,
      value: object_id
    }
  end

  # rubocop:disable RSpec/NestedGroups
  describe '#show' do
    context 'when trying to download a supply teachers document in RM6238' do
      let(:signed_id) { admin_upload.current_accredited_suppliers.blob.signed_id }
      let(:filename) { admin_upload.current_accredited_suppliers.blob.filename }
      let(:object_id_key) { :st_rm6238_upload_id }
      let(:object_id) { admin_upload.id }
      let(:admin_upload) { create(:supply_teachers_rm6238_admin_upload_with_document) }

      context 'when signed in as an st buyer' do
        login_st_buyer

        it 'redirects to the not permitted path' do
          get :show

          expect(response).to redirect_to supply_teachers_rm6238_not_permitted_path
        end
      end

      context 'when signed in as an mc buyer' do
        login_mc_buyer

        it 'redirects to the not permitted path' do
          get :show

          expect(response).to redirect_to supply_teachers_rm6238_not_permitted_path
        end
      end

      context 'when signed in as an ls buyer' do
        login_ls_buyer

        it 'redirects to the not permitted path' do
          get :show

          expect(response).to redirect_to supply_teachers_rm6238_not_permitted_path
        end
      end

      context 'when signed in as an st admin' do
        login_st_admin

        it 'allows the blob to be downloaded' do
          get :show

          expect(response).to have_http_status(:found)
        end

        context 'when the key is not passed' do
          it 'redirects to the not permitted path' do
            default_params.delete(:key)

            get :show

            expect(response).to redirect_to supply_teachers_rm6238_not_permitted_path
          end
        end

        context 'when the value is not passed' do
          it 'redirects to the not permitted path' do
            default_params.delete(:value)

            get :show

            expect(response).to redirect_to supply_teachers_rm6238_not_permitted_path
          end
        end

        context 'when the key is not valid' do
          let(:object_id_key) { :fake_procurement_id_key }

          it 'redirects to the not permitted path' do
            get :show

            expect(response).to redirect_to supply_teachers_rm6238_not_permitted_path
          end
        end

        context 'when the object does not exist' do
          let(:object_id) { SecureRandom.uuid }

          it 'is raise a routing error' do
            expect { get :show }.to raise_error(ActionController::RoutingError)
          end
        end
      end

      context 'when signed in as an mc admin' do
        login_mc_admin

        it 'allows the blob to be downloaded' do
          get :show

          expect(response).to have_http_status(:found)
        end
      end

      context 'when signed in as an ls admin' do
        login_ls_admin

        it 'allows the blob to be downloaded' do
          get :show

          expect(response).to have_http_status(:found)
        end
      end
    end

    context 'when trying to download a management consultancy document in RM6187' do
      let(:signed_id) { admin_upload.supplier_details_file.blob.signed_id }
      let(:filename) { admin_upload.supplier_details_file.blob.filename }
      let(:object_id_key) { :mc_rm6187_upload_id }
      let(:object_id) { admin_upload.id }
      let(:admin_upload) { create(:management_consultancy_rm6187_admin_upload_with_document) }

      context 'when signed in as an st buyer' do
        login_st_buyer

        it 'redirects to the not permitted path' do
          get :show

          expect(response).to redirect_to supply_teachers_rm6238_not_permitted_path
        end
      end

      context 'when signed in as an mc buyer' do
        login_mc_buyer

        it 'redirects to the not permitted path' do
          get :show

          expect(response).to redirect_to supply_teachers_rm6238_not_permitted_path
        end
      end

      context 'when signed in as an ls buyer' do
        login_ls_buyer

        it 'redirects to the not permitted path' do
          get :show

          expect(response).to redirect_to supply_teachers_rm6238_not_permitted_path
        end
      end

      context 'when signed in as an st admin' do
        login_st_admin

        it 'allows the blob to be downloaded' do
          get :show

          expect(response).to have_http_status(:found)
        end
      end

      context 'when signed in as an mc admin' do
        login_mc_admin

        it 'allows the blob to be downloaded' do
          get :show

          expect(response).to have_http_status(:found)
        end

        context 'when the key is not passed' do
          it 'redirects to the not permitted path' do
            default_params.delete(:key)

            get :show

            expect(response).to redirect_to supply_teachers_rm6238_not_permitted_path
          end
        end

        context 'when the value is not passed' do
          it 'redirects to the not permitted path' do
            default_params.delete(:value)

            get :show

            expect(response).to redirect_to supply_teachers_rm6238_not_permitted_path
          end
        end

        context 'when the key is not valid' do
          let(:object_id_key) { :fake_procurement_id_key }

          it 'redirects to the not permitted path' do
            get :show

            expect(response).to redirect_to supply_teachers_rm6238_not_permitted_path
          end
        end

        context 'when the object does not exist' do
          let(:object_id) { SecureRandom.uuid }

          it 'is raise a routing error' do
            expect { get :show }.to raise_error(ActionController::RoutingError)
          end
        end
      end

      context 'when signed in as an ls admin' do
        login_ls_admin

        it 'allows the blob to be downloaded' do
          get :show

          expect(response).to have_http_status(:found)
        end
      end
    end

    context 'when trying to download a legal services document in RM6240' do
      let(:signed_id) { admin_upload.supplier_details_file.blob.signed_id }
      let(:filename) { admin_upload.supplier_details_file.blob.filename }
      let(:object_id_key) { :ls_rm6240_upload_id }
      let(:object_id) { admin_upload.id }
      let(:admin_upload) { create(:legal_services_rm6240_admin_upload_with_document) }

      context 'when signed in as an st buyer' do
        login_st_buyer

        it 'redirects to the not permitted path' do
          get :show

          expect(response).to redirect_to supply_teachers_rm6238_not_permitted_path
        end
      end

      context 'when signed in as an mc buyer' do
        login_mc_buyer

        it 'redirects to the not permitted path' do
          get :show

          expect(response).to redirect_to supply_teachers_rm6238_not_permitted_path
        end
      end

      context 'when signed in as an ls buyer' do
        login_ls_buyer

        it 'redirects to the not permitted path' do
          get :show

          expect(response).to redirect_to supply_teachers_rm6238_not_permitted_path
        end
      end

      context 'when signed in as an st admin' do
        login_st_admin

        it 'allows the blob to be downloaded' do
          get :show

          expect(response).to have_http_status(:found)
        end
      end

      context 'when signed in as an mc admin' do
        login_mc_admin

        it 'allows the blob to be downloaded' do
          get :show

          expect(response).to have_http_status(:found)
        end
      end

      context 'when signed in as an ls admin' do
        login_ls_admin

        it 'allows the blob to be downloaded' do
          get :show

          expect(response).to have_http_status(:found)
        end

        context 'when the key is not passed' do
          it 'redirects to the not permitted path' do
            default_params.delete(:key)

            get :show

            expect(response).to redirect_to supply_teachers_rm6238_not_permitted_path
          end
        end

        context 'when the value is not passed' do
          it 'redirects to the not permitted path' do
            default_params.delete(:value)

            get :show

            expect(response).to redirect_to supply_teachers_rm6238_not_permitted_path
          end
        end

        context 'when the key is not valid' do
          let(:object_id_key) { :fake_procurement_id_key }

          it 'redirects to the not permitted path' do
            get :show

            expect(response).to redirect_to supply_teachers_rm6238_not_permitted_path
          end
        end

        context 'when the object does not exist' do
          let(:object_id) { SecureRandom.uuid }

          it 'is raise a routing error' do
            expect { get :show }.to raise_error(ActionController::RoutingError)
          end
        end
      end
    end
  end
  # rubocop:enable RSpec/NestedGroups
end
