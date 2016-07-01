Sidekiq.configure_server do |config|
	config.redis = { :size => 2 }
  config.redis = { url: ENV["REDISTOGO_URL"] }
end unless ENV["REDISTOGO_URL"].blank?

Sidekiq.configure_client do |config|
	config.redis = { :size => 1 }
  config.redis = { url: ENV["REDISTOGO_URL"] }
end unless ENV["REDISTOGO_URL"].blank?