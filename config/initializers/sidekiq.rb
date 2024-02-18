redis_url = "#{ENV['REDIS_HOST']}:#{ENV['REDIS_PORT']}/0"
sidekiq_config = { url: "redis://#{redis_url}", logfile: "log/sidekiq.log" }

Sidekiq.configure_server do |config|
  config.redis = sidekiq_config
end

Sidekiq.configure_client do |config|
  config.redis = sidekiq_config
end

# Limit max number of retries for jobs to 3
Sidekiq.default_worker_options = { :retry => 3, :backtrace => true }
