class ReservationSegment < ApplicationRecord
  belongs_to :user
  belongs_to :trip
  belongs_to :city
end
