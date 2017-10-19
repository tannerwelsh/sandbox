require 'ripper'
require 'graphviz'

class Array
  def traverse_tree(&block)
    self.each_with_index do |elem, index|
      if elem.is_a? Array
        elem.traverse_tree(&block)
      else
        block.call(elem, self[(index + 1)..-1])
      end
    end
  end

  def select_nodes
    selection = []

    self.traverse_tree do |node, values|
      selection << [node, values] if yield(node)
    end

    selection
  end
end



default_file = File.expand_path('../test_file.rb', __FILE__)

filename = ARGV.empty? ? default_file : ARGV.first
s_expression = Ripper.sexp(File.read(filename))

objs = s_expression.select_nodes { |n| n == :class }

objs.each { |c| p c}
