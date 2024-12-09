require "test_helper"

class RtcChannelTest < ActionCable::Channel::TestCase
  test "subscribes" do
    subscribe
    assert subscription.confirmed?
  end
end
