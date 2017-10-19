class Timer

  def initialize(duration = "25:00")
    @duration = duration
    @mins, @secs = parse_duration
  end

  def start(&block)
    count_minutes(&block)
    alert
  end

  def alert
    `afplay /System/Library/Sounds/Ping.aiff`
  end

private

  def parse_duration
    @duration.split(":").map(&:to_i)
  end

  def clock
    mins = @mins < 10 ? "0#{@mins}" : @mins.to_s
    secs = @secs < 10 ? "0#{@secs}" : @secs.to_s
    
    mins + ":" + secs 
  end

  def count_minutes(&block)
    yield clock 
    while @mins > 0
      subtract_minute if @secs == 0
      count_seconds(&block)
    end
  end

  def count_seconds(&block)
    while @secs > 0
      sleep 10
      @secs -= 10
      yield clock 
    end
  end

  def subtract_minute
    @mins -= 1
    @secs =  60
  end
end


Timer.new(ARGV[0]).start { |clock| puts clock }
