require "test_helper"

class PrintService < ActiveSupport::TestCase
  setup do
    Import.new(Rails.root.join('public','data.txt')).perform
  end
  test "Test Printer returns String and Includes Hotel word" do
    output = Print.new(Trip.all).perform
    assert output.include?('Hotel') && output.class == String
  end
end
