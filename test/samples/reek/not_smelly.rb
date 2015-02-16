class Perfume
  attr_reader :perfumed

  def ignoreRubyStyle(oneParameter)
    oneVariable = oneParameter
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

  def allow_up_to_two_duplicate_method_calls
    respond_to do |format|
      if success
        format.html { redirect_to some_path }
        format.js { head :ok }
      else
        format.html { redirect_to :back, status: :bad_request }
        format.js { render status: :bad_request }
      end
    end
  end
end
