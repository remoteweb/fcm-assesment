require "test_helper"

class ImportService < ActiveSupport::TestCase
  setup do
  end
  
  test "Testing Import" do
    assert_difference('Trip.count' => 2, 'ReservationSegment.count' => 6, 'User.count' => 1, 'City.count' => 3) do
      Import.new(Rails.root.join('public','data.txt')).perform
    end
  end
end
