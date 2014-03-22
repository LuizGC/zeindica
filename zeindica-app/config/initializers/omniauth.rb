Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['app_id'], ENV['app_secret'], :scope => 'email, publish_stream'
end
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE 
