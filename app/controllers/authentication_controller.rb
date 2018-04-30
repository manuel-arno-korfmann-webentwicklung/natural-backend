# Authentication implementation mostly copied and slightly adapted from
# https://paweljw.github.io/2017/07/rails-5.1-api-app-part-4-authentication-and-authorization/
# Big thanks!

class AuthenticationController < ApplicationController
  skip_before_action :authenticate_user

  def authenticate
    token_command = CreateNewOrAuthenticateUser.call(*params.slice(:email, :password).values)

    if token_command.success?
      render json: { token: token_command.result }
    else
      render json: { error: token_command.errors }, status: token_command.status
    end
  end
end
