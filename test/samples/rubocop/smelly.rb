class AllTheMethods
  def method_missing(method, *args, &block)
    message = "I"
    message = " did not"
    message << " exist,"
    message << " but now"
    message << " I do."
    self.class.send(:define_method, method) { "I did not exist, but now I do." }
    send(method)
  end
end
