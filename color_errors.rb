require 'colored'

STDIN.puts('foo')

puts STDIN.gets(3)

#class Exception
  #def to_s
    #'foo'
  #end

   #def backtrace
     #super
   #end
#end

#class StandardError
  #def backtrace
    #prev = super

    #p prev.class
  #end
#end

#foo

begin
  foo
rescue Exception => e
  e.backtrace.map! do |path|
    path.sub(/\w+\.rb\:\d+/) do |file_and_line|
      basename, lineno = file_and_line.split(':')
      basename.blue + ':' + lineno.red
    end
  end
  raise
end
