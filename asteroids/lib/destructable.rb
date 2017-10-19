module Destructable
  def self.included(base)
    base.class_eval do
      attr_reader :dead
      alias_method :dead?, :dead
    end
  end

  def kill
    @dead = true
  end

  def respawn
    @dead = false
  end
end
