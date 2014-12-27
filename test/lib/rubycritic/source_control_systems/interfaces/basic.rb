module BasicInterface
  def test_implements_basic_interface
    assert_respond_to @system, :revisions_count
    assert_respond_to @system, :date_of_last_commit
    assert_respond_to @system, :revision?
  end
end
