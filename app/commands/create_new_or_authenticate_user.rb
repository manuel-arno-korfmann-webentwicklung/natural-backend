# Authentication implementation mostly copied and slightly adapted from
# https://paweljw.github.io/2017/07/rails-5.1-api-app-part-4-authentication-and-authorization/
# Big thanks!


class CreateNewOrAuthenticateUser < BaseCommand
  class UserNotPersistedError < StandardError;end

  private

  attr_reader :email, :password

  def initialize(email, password)
    @email = email
    @password = password
  end

  def user
    @user ||= find_or_create_user
  end

  def find_or_create_user
    u = User.find_or_initialize_by(email: email)

    if u.new_record?
      persist_user(u)
    end

    u
  end

  def persist_user(u)
    u.password = @password
    unless u.save
      self.errors += u.errors
      self.status = 500
      raise UserNotPersistedError
    end
  end

  def password_valid?
    user && user.authenticate(password)
  end

  def run
    if password_valid?
      @result = JwtService.encode(content)
    else
      errors.add(:base, "Invalid credentials")
    end
  rescue UserNotPersistedError
  end

  def content
    {
      user_id: user.id,
      exp: 24.hours.from_now.to_i
    }
  end
end
