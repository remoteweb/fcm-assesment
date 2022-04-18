class User < ApplicationRecord
  belongs_to :city
  has_many :trips
  has_many :reservation_segments
end
