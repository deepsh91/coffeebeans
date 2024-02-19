redis_url = "#{ENV['REDIS_HOST']}:#{ENV['REDIS_PORT']}/0"

Sidekiq.configure_server do |config|
  config.redis = { url: "redis://#{redis_url}" }
  config.logger = Sidekiq::Logger.new($stdout)
end

Sidekiq.configure_client do |config|
  config.redis = { url: "redis://#{redis_url}" }
  config.logger = Sidekiq::Logger.new($stdout)
end
