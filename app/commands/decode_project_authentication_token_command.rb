# Authentication implementation mostly copied and slightly adapted from
# https://paweljw.github.io/2017/07/rails-5.1-api-app-part-4-authentication-and-authorization/
# Big thanks!

class DecodeProjectAuthenticationTokenCommand < BaseCommand
  private

  attr_reader :headers

  def initialize(headers)
    @headers = headers
    @project = nil
  end

  def run
    return unless token_present?
    @result = project if project
  end

  def project
    @project ||= Project.find_by(id: decoded_id)
    @project || errors.add(:token, "Token invalid") && nil
  end

  def token_present?
    token.present? && token_contents.present?
  end

  def token
    return authentication_header.split(' ').last if authentication_header.present?
    errors.add(:token, "Token missing")
    nil
  end

  def authentication_header
    headers['Authentication']
  end

  def token_contents
    @token_contents ||= begin
      decoded = JwtService.decode(token)
      Rails.logger.info(decoded)
      errors.add(:token, "Token expired") unless decoded
      decoded
    end
  end

  def decoded_id
    token_contents['project_id']
  end
end
