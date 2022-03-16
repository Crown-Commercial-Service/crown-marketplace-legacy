module Base
  class SessionsController < Devise::SessionsController
    skip_forgery_protection
    before_action :authenticate_user!, except: %i[new create destroy]
    before_action :authorize_user, except: %i[new create destroy]
    before_action :validate_service, except: :destroy

    def new
      @result = Cognito::SignInUser.new(nil, nil, nil)
      super
    end

    def create
      self.resource ||= User.new
      @result = Cognito::SignInUser.new(params[:user][:email], params[:user][:password], request.cookies.blank?)
      @result.call

      if @result.success?
        @result.challenge? ? redirect_to(challenge_path) : super
      else
        result_unsuccessful_path
      end
    end

    def destroy
      session.delete(current_user.id)
      current_user.invalidate_session!
      current_user.save!
      super
    end

    protected

    def after_sign_in_path_for(resource)
      stored_location_for(resource) || gateway_url
    end

    def after_sign_out_path_for(_resource)
      gateway_url
    end

    def authorize_user
      authorize! :read, SupplyTeachers
    end

    def challenge_path
      cookies[:crown_marketplace_challenge_session] = { value: @result.session, expires: 20.minutes, httponly: true }
      cookies[:crown_marketplace_challenge_username] = { value: @result.cognito_uuid, expires: 20.minutes, httponly: true }

      service_challenge_path
    end

    def result_unsuccessful_path
      sign_out
      if @result.needs_password_reset
        cookies[:crown_marketplace_reset_email] = { value: params[:user][:email], expires: 20.minutes, httponly: true }

        redirect_to confirm_forgot_password_path
      elsif @result.needs_confirmation
        cookies[:crown_marketplace_confirmation_email] = { value: params[:user][:email], expires: 20.minutes, httponly: true }

        redirect_to confirm_email_path
      else
        render :new
      end
    end
  end
end
