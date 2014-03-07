class AllTheMethods
  def method_missing(method, *args, &block)
    define_method(method) { "I did not exist, but now I do." }
    send(method)
  end
end
