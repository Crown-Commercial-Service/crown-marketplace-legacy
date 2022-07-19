# rubocop:disable Metrics/BlockLength
require 'sidekiq/web'
Rails.application.routes.draw do
  get '/', to: 'home#index'
  get '/status', to: 'home#status'

  authenticate :user, ->(u) { u.has_role? :ccs_employee } do
    mount Sidekiq::Web => '/sidekiq-log'
  end

  devise_for :users, skip: %i[registrations passwords sessions]
  devise_scope :user do
    concern :authenticatable do
      get '/sign-in', to: 'sessions#new', as: :new_user_session
      post '/sign-in', to: 'sessions#create', as: :user_session
      delete '/sign-out', to: 'sessions#destroy', as: :destroy_user_session
      get '/users/forgot-password', to: 'passwords#new', as: :new_user_password
      post '/users/password', to: 'passwords#create'
      get '/users/password', to: 'passwords#edit', as: :edit_user_password
      put '/users/password', to: 'passwords#update'
      get '/users/password-reset-success', to: 'passwords#password_reset_success', as: :password_reset_success
      get '/users/confirm', to: 'users#confirm_new'
      post '/users/confirm', to: 'users#confirm'
      get '/users/challenge', to: 'users#challenge_new'
      post '/users/challenge', to: 'users#challenge'
      post '/resend_confirmation_email', to: 'users#resend_confirmation_email', as: :resend_confirmation_email
    end
    concern :registrable do
      get '/sign-up', to: 'registrations#new', as: :new_user_registration
      post '/sign-up', to: 'registrations#create', as: :user_registration
      get '/domain-not-on-safelist', to: 'registrations#domain_not_on_safelist', as: :domain_not_on_safelist
    end

    delete '/sign-out', to: 'base/sessions#destroy', as: :destroy_user_session

    namespace 'supply_teachers', path: 'supply-teachers', defaults: { service: 'supply_teachers' } do
      namespace 'rm3826', path: 'RM3826', defaults: { framework: 'RM3826' } do
        concerns :authenticatable
        namespace :admin, defaults: { service: 'supply_teachers/admin' } do
          concerns :authenticatable
        end
      end
      namespace 'rm6238', path: 'RM6238', defaults: { framework: 'RM6238' } do
        concerns :authenticatable
        namespace :admin, defaults: { service: 'supply_teachers/admin' } do
          concerns :authenticatable
        end
      end
    end

    namespace 'management_consultancy', path: 'management-consultancy', defaults: { service: 'management_consultancy' } do
      namespace 'rm6187', path: 'RM6187', defaults: { framework: 'RM6187' } do
        concerns %i[authenticatable registrable]
        namespace :admin, defaults: { service: 'management_consultancy/admin' } do
          concerns :authenticatable
        end
      end
    end

    namespace 'legal_services', path: 'legal-services', defaults: { service: 'legal_services' } do
      namespace 'rm3788', path: 'RM3788', defaults: { framework: 'RM3788' } do
        concerns %i[authenticatable registrable]
        namespace :admin, defaults: { service: 'legal_services/admin' } do
          concerns :authenticatable
        end
      end
    end
  end

  concern :buyer_shared_pages do
    get '/', to: 'home#index'
  end

  concern :shared_pages do
    get '/not-permitted', to: 'home#not_permitted'
    get '/accessibility-statement', to: 'home#accessibility_statement'
    get '/cookie-policy', to: 'home#cookie_policy'
    get '/cookie-settings', to: 'home#cookie_settings'
  end

  concern :admin_shared_pages do
    get '/not-permitted', to: 'uploads#not_permitted'
    get '/accessibility-statement', to: 'uploads#accessibility_statement'
    get '/cookie-policy', to: 'uploads#cookie_policy'
    get '/cookie-settings', to: 'uploads#cookie_settings'
  end

  concern :framework do
    get '/', to: 'home#framework'
  end

  concern :admin_frameworks do
    resources :frameworks, only: %i[index edit update] if Marketplace.can_edit_legacy_frameworks?
  end

  concern :admin_uploads do
    resources :uploads, only: %i[index new create show] do
      get '/progress', action: :progress
    end
    get '/', to: 'uploads#index'
  end

  concern :gateway do
    get '/cognito', to: 'gateway#index', cognito_enabled: true
    get '/gateway', to: 'gateway#index'
  end

  namespace 'supply_teachers', path: 'supply-teachers', defaults: { service: 'supply_teachers' } do
    concerns :framework

    namespace :admin, defaults: { service: 'supply_teachers/admin' } do
      concerns %i[framework admin_frameworks]
    end

    namespace 'rm3826', path: 'RM3826', defaults: { framework: 'RM3826' } do
      concerns %i[buyer_shared_pages shared_pages gateway]
      get '/temp-to-perm-fee', to: 'home#temp_to_perm_fee'
      get '/fta-to-perm-fee', to: 'home#fta_to_perm_fee'
      get '/master-vendors', to: 'suppliers#master_vendors', as: 'master_vendors'
      # get '/neutral-vendors', to: 'suppliers#neutral_vendors', as: 'neutral_vendors'
      get '/all-suppliers', to: 'suppliers#all_suppliers', as: 'all_suppliers'
      get '/agency-payroll-results', to: 'branches#index', slug: 'agency-payroll-results'
      get '/fixed-term-results', to: 'branches#index', slug: 'fixed-term-results', as: 'fixed_term_results'
      get '/nominated-worker-results', to: 'branches#index', slug: 'nominated-worker-results'
      resources :branches, only: %i[index show]
      resources :downloads, only: :index

      namespace :admin, defaults: { service: 'supply_teachers/admin' } do
        get '/', to: 'uploads#index'
        resources :uploads, only: %i[index new create show destroy update]
        concerns :admin_shared_pages
      end
    end

    namespace 'rm6238', path: 'RM6238', defaults: { framework: 'RM6238' } do
      concerns %i[buyer_shared_pages shared_pages gateway]
      resources :suppliers, path: '/', only: %i[] do
        collection do
          get '/master-vendors', action: :master_vendors
        end
      end

      namespace :admin, defaults: { service: 'supply_teachers/admin' } do
        get '/', to: 'uploads#index'
        resources :uploads, only: %i[index new create show destroy update]
        concerns :admin_shared_pages
      end
    end

    get '/:framework', to: 'home#index', as: 'index'
    get '/:framework/admin', to: 'admin/home#index', defaults: { service: 'supply_teachers/admin' }, as: 'admin_index'
    get '/:framework/start', to: 'journey#start', as: 'journey_start'
    get '/:framework/:slug', to: 'journey#question', as: 'journey_question'
    get '/:framework/:slug/answer', to: 'journey#answer', as: 'journey_answer'
  end

  namespace 'management_consultancy', path: 'management-consultancy', defaults: { service: 'management_consultancy' } do
    concerns :framework

    namespace :admin, defaults: { service: 'management_consultancy/admin' } do
      concerns %i[framework admin_frameworks]
    end

    namespace 'rm6187', path: 'RM6187', defaults: { framework: 'RM6187' } do
      concerns %i[buyer_shared_pages shared_pages]
      get '/suppliers', to: 'suppliers#index'
      get '/suppliers/download', to: 'suppliers#download', as: 'suppliers_download'
      get '/suppliers/:id', to: 'suppliers#show', as: 'supplier'
      namespace :admin, defaults: { service: 'management_consultancy/admin' } do
        concerns %i[admin_uploads admin_shared_pages]
      end
    end

    get '/:framework', to: 'home#index', as: 'index'
    get '/:framework/admin', to: 'admin/home#index', defaults: { service: 'management_consultancy/admin' }, as: 'admin_index'
    get '/:framework/start', to: 'journey#start', as: 'journey_start'
    get '/:framework/:slug', to: 'journey#question', as: 'journey_question'
    get '/:framework/:slug/answer', to: 'journey#answer', as: 'journey_answer'
  end

  namespace 'legal_services', path: 'legal-services', defaults: { service: 'legal_services' } do
    concerns :framework

    namespace :admin, defaults: { service: 'legal_services/admin' } do
      concerns %i[framework admin_frameworks]
    end

    namespace 'rm3788', path: 'RM3788', defaults: { framework: 'RM3788' } do
      concerns %i[buyer_shared_pages shared_pages]
      get '/service-not-suitable', to: 'home#service_not_suitable'
      get '/suppliers/download', to: 'suppliers#download'
      get '/suppliers/no-suppliers-found', to: 'suppliers#no_suppliers_found'
      get '/suppliers/cg-no-suppliers-found', to: 'suppliers#cg_no_suppliers_found'
      resources :suppliers, only: %i[index show]
      resources :downloads, only: :index
      namespace :admin, defaults: { service: 'legal_services/admin' } do
        concerns %i[admin_uploads admin_shared_pages]
      end
    end

    get '/:framework', to: 'home#index', as: 'index'
    get '/:framework/admin', to: 'admin/home#index', defaults: { service: 'legal_services/admin' }, as: 'admin_index'
    get '/:framework/start', to: 'journey#start', as: 'journey_start'
    get '/:framework/:slug', to: 'journey#question', as: 'journey_question'
    get '/:framework/:slug/answer', to: 'journey#answer', as: 'journey_answer'
  end

  get '/404', to: 'errors#not_found', as: :errors_404
  get '/422', to: 'errors#unacceptable', as: :errors_422
  get '/500', to: 'errors#internal_error', as: :errors_500
  get '/503', to: 'errors#service_unavailable', as: :errors_503

  if Marketplace.dfe_signin_enabled?
    post '/auth/dfe', as: :dfe_sign_in
    get '/auth/dfe/callback' => 'auth#callback'
  end

  get '/:journey/:framework/start', to: 'journey#start', as: 'journey_start'
  get '/:journey/:framework/:slug', to: 'journey#question', as: 'journey_question'
  get '/:journey/:framework/:slug/answer', to: 'journey#answer', as: 'journey_answer'
end
# rubocop:enable Metrics/BlockLength
