class Baseball
  def toss(receiver)
    receiver.catch_ball(self)
  end
end

class Player
  attr_accessor :ball

  def catch_ball(ball)
    self.ball = ball
  end

  def toss(receiver)
    ball.toss(receiver)
    self.ball = nil
  end

  def has_ball?
    !!ball
  end
end

class BallGame
  attr_reader :players, :ball

  def initialize(*players)
    @players = players
    @ball = Baseball.new
  end

  def play
    players.first.ball = ball

    i = 0
    until players.last.has_ball?
      players[i].toss(players[i + 1])
      i += 1
    end

    true
  end
end
