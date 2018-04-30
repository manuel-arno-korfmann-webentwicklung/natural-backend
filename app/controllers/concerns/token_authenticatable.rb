# Authentication implementation mostly copied and slightly adapted from
# https://paweljw.github.io/2017/07/rails-5.1-api-app-part-4-authentication-and-authorization/
# Big thanks!


class NotAuthenticatedException < StandardError; end

module TokenAuthenticatable
  extend ActiveSupport::Concern

  included do
    attr_reader :current_user

    before_action :authenticate_user

    rescue_from NotAuthenticatedException, with: -> { render json: { error: 'Not Authenticated' }, status: 403 }
  end

  private

  def authenticate_user
    decode_authentication_command = DecodeAuthenticationCommand.call(request.headers)
    @current_user = decode_authentication_command.result
    raise NotAuthenticatedException unless @current_user
  end
end
