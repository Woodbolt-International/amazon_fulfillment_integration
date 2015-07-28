require 'redis'

class OrderStore
  def add(id)
    redis.lpush 'orders', id
  end

  def delete(id)
    redis.lrem 'orders', 1, id
  end

  def all
    redis.lrange 'orders', 0, -1
  end

  def redis
    @redis ||= Redis.new
  end
end
