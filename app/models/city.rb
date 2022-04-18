class City < ApplicationRecord
  has_many :trips
  has_many :users 
end
