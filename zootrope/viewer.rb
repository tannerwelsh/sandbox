require 'gosu'
require 'set'

class Zootrope
  def initialize
    @window = Zootrope::MainWindow.new
    @files = Set.new
    at_exit { show }
  end

  def trace
    set_trace_func proc { |event, file, line, id, binding, classname|
      if event == "class"
        @files << file
        @window << RubyClass.new(@window, binding.eval("self"))
      end
    }
  end

  def show
    @files.each do |file|
      next if file == __FILE__
      File.readlines(file).each_with_index do |line, line_no|
        @window << FileText.new(@window, line.chomp, line_no * 13)
      end
    end

    @window.show
  end

  def close
    @window.close
  end

  class MainWindow < Gosu::Window
    attr_reader :sprites

    def initialize
      super(900, 480, false)
      self.caption = "Zootrope"
      @sprites = []
    end

    def <<(sprite)
      @sprites << sprite
    end

    def update
      # sleep 1
    end

    def draw
      @sprites.each(&:draw)
    end
  end

  class FileText
    def initialize(window, text, y = 0)
      @window, @text = window, text
      @x, @y = 0, y

      @font = Gosu::Font.new(@window, 'Monaco', 13)
    end

    def draw
      @font.draw(@text, 0, @y, 1)
    end
  end

  class RubyClass
    def initialize(window, name)
      @window, @name = window, name

      @x, @y = rand * 640 + 260, rand * 480

      @src = File.expand_path('../green_box.png', __FILE__)
      # @img = Gosu::Image.new(window, @src, false)
      @title = Gosu::Image.from_text(@window, @name, 'Helvetica', 18, 12, 200, :center)
    end

    def draw
      # @img.draw(320, 200, 1)
      @title.draw(@x, @y, 2)
    end
  end
end
