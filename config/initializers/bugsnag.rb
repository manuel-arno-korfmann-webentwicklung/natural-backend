Bugsnag.configure do |config|
  config.api_key = Rails.application.secrets.bugsnag 
end
