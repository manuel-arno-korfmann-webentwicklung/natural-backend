# Authentication implementation mostly copied and slightly adapted from
# https://paweljw.github.io/2017/07/rails-5.1-api-app-part-4-authentication-and-authorization/
# Big thanks!

class JwtService
  def self.encode(payload)
    JWT.encode(payload, Rails.application.secrets.secret_key_base, 'HS256')
  end

  def self.decode(token)
    body = JWT.decode(token, Rails.application.secrets.secret_key_base,
                       true, algorithm: 'HS256')
    HashWithIndifferentAccess.new(body[0])
  rescue JWT::ExpiredSignature
    nil
  end
end
