require 'redis'
require 'bcrypt'

module RedisAdapter
  def self.included(base)
    base.extend(ClassMethods)
    base.class_eval do

      def downcase_username
        self.username = username.downcase
      end

      def save
        return false unless valid?

        downcase_username

        self.class.set(username, self.to_json)
        true
      rescue Redis::CommandError
        false
      end

    end
  end

  module ClassMethods
    def find(username)
      record = redis.get(redis_key(username))
      record ? new(JSON.parse(record)) : nil
    end

    def all
      keys = redis.keys(redis_key('*'))
      keys.map { |key| { username: JSON.parse(redis.get(key))['username'] } }
    end

    def set(username, data)
      redis.set(redis_key(username), data)
    end

    private

    def redis
      @redis ||= Redis.new
    end

    def redis_key(username)
      "Users:#{username}"
    end
  end
end
