# set_trace_func proc { |event, file, line, id, binding, classname|
#   case event
#   when "class"

#   end
# }

# class Object
#   def singleton_method_added(id)
#     p "Adding #{id}"
#   end
# end

# class Foo
#   def bar
#     puts "The callee is #{__callee__}"
#   end

#   def self.bar; end
# end

# Foo.new.bar



printf "%8s %15s:%2s %25s %25s %20s\n", "EVENT", "FILE", "LN", "ID", "BINDING", "CLASSNAME"
set_trace_func proc { |event, file, line, id, binding, classname|
  if event =~ /class|call/
    printf "%8s %15s:%-2d %25s %25s %20s\n", event, file, line, id, binding.eval("self"), classname
  end
}
class Bar
  def foo
    self
  end
end

class Test < Bar
  def test(obj)
    obj.foo
  end
end

t = Test.new
b = Bar.new
t.test(b)

