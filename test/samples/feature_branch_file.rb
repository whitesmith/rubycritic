class Signup 
  def flay(parts)
    parts -= 1
    parts -= 2
    parts -= 3
    parts -= 4
  end

  def method_missing(method, *args, &block)
    message = "I"
    eval "message = ' did not'"
    eval "message << ' exist,'"
    eval "message << ' but now'"
    eval "message << ' I do.'"
    self.class.send(:define_method, method) { "I did not exist, but now I do." }
    self.send(method)
  end

  def allow_nesting_iterators_two_levels_deep
    loop do
      loop do
      end
    end
  end

  def allow_many_statements
    do_something
    do_something
    do_something
    do_something
    do_something
    do_something
  end
end