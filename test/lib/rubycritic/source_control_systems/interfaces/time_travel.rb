# This interface is only used if `@system.revision?` returns `true`.
module TimeTravelInterface
  def test_implements_time_travel_interface
    assert_respond_to @system, :head_reference
    assert_respond_to @system, :travel_to_head
  end
end
