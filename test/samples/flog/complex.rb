class AllTheMethods
  def method_missing(method, *args, &block)
    message = "I"
    eval "message = ' did not'"
    eval "message << ' exist,'"
    eval "message << ' but now'"
    eval "message << ' I do.'"
    self.class.send(:define_method, method) { "I did not exist, but now I do." }
    self.send(method)
  end
end
