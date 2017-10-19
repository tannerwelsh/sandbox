module Foo
  def self.run_code(proc = nil, &block)
    yield if block_given?                # => nil, nil, nil
    proc.call if proc                    # => nil, nil, Foo
  end                                    # => nil

  def self.my_proc
    proc { p self }  # => #<Proc:0x007feaba8c4838@/var/folders/cd/bswdrfrn5bn63gh0jh790plc0000gn/T/seeing_is_believing_temp_dir20130810-9283-1ilktki/program.rb:8>
  end                # => nil

  run_code {
    def self.this_is_me
      p self             # => Foo
    end                  # => nil
  }                      # => nil
end                      # => nil

Foo.run_code {
  def self.hi_there
    p self           # => main
  end                # => nil
}                    # => nil

Foo.run_code Foo.my_proc  # => Foo

hi_there  # => main

Foo.this_is_me  # => Foo

# >> Foo
# >> main
# >> Foo
