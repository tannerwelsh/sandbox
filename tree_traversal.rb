class Dictionary
  def include?(word)
    chars = prepare_word(word)

    chars.inject(word_tree) do |remaining, char|
      remaining = remaining[char]
      return false if remaining.nil?
      remaining
    end
    true
  end

  def prepare_word(word)
    word = word.split('')
    word << :eof
  end

  def traverse_find(word, tree = word_tree)
    word = prepare_word(word) if word.is_a? String
    this_char = word.shift
    remaining = tree[this_char]

    if remaining.nil?
      return false
    elsif remaining == true
      return true
    else
      traverse_find(word, remaining)
    end
  end

  def word_tree
    # 'angry abbacus abba artichoke artful artist angel'
    @word_tree ||=
      {"a"=>{"b"=>{"b"=>{"a"=>{:eow=>true,
                               "c"=>{"u"=>{"s"=>{:eow=>true}}}}}},
             "n"=>{"g"=>{"e"=>{"l"=>{:eow=>true}},
                         "r"=>{"y"=>{:eow=>true}}}},
             "r"=>{"t"=>{"f"=>{"u"=>{"l"=>{:eow=>true}}},
                         "i"=>{"c"=>{"h"=>{"o"=>{"k"=>{"e"=>{:eow=>true}}}}},
                               "s"=>{"t"=>{:eow=>true}}}}}}}
  end
end

require 'benchmark'

dict = Dictionary.new

n = 10000

Benchmark.bm do |marker|
  marker.report('include?') {
    n.times do
      dict.include? 'angry'
      dict.include? 'anger'
      dict.include? 'angel'
      dict.include? 'angelic'
    end
  }

  marker.report('traverse_find') {
    n.times do
      #dict.traverse_find ['a', 'n', 'g', 'r', 'y', :eow]
      #dict.traverse_find ['a', 'n', 'g', 'e', 'r', :eow]
      dict.traverse_find dict.prepare_word 'angry'
      dict.traverse_find dict.prepare_word 'anger'
      dict.traverse_find dict.prepare_word 'angel'
      dict.traverse_find dict.prepare_word 'angelic'
    end
  }
end
