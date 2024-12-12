class Rack::Attack
  Rack::Attack.cache.store = ActiveSupport::Cache::RedisCacheStore.new(url: 'redis://localhost:6379')

  # Throttle login attempts by IP address
  throttle('login/ip', limit: 5, period: 20.seconds) do |req|
    req.ip if req.path == '/auth/login' && req.post?
  end

  # Throttle login attempts by username
  throttle('login/username', limit: 5, period: 20.seconds) do |req|
    if req.path == '/auth/login' && req.post?
      req.params['auth']['username'].to_s.downcase
    end
  end
end
