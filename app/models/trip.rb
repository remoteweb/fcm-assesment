class Trip < ApplicationRecord
  has_many :reservation_segments
  belongs_to :city
  belongs_to :user

  before_save :update_trip_completeness
  
  def self.RESERVATION_TYPES 
    {
      transportation: ['Flight','Train'],
      other: 'Hotel'
    }
  end

  def self.append_to_existing_or_create_new_trip(segment, user)
    reservation_segment = user.reservation_segments.build
    reservation_segment.origin = segment.origin 
    
    if segment.transportation? && 
        segment.aller?
      
      reservation_segment.destination = segment.destination
      reservation_segment.rank = 0
      city = City.find_or_create_by(code: segment.destination)
      
      trip = user.trips.find_or_create_by(city_id: city.id, completed: false)
      trip.update(start_at: segment.start_at)

    elsif segment.transportation? && 
      segment.retour?
      
      reservation_segment.destination = segment.destination
      reservation_segment.rank = 1000000
      city = City.find_or_create_by(code: segment.origin)
      
      trip = user.trips.find_or_create_by(city_id: city.id, completed: false)
      trip.update(end_at: segment.end_at)
      
    elsif segment.hotel?
      reservation_segment.rank = 500000
      city = City.find_or_create_by(code: segment.origin)

      trips = user.trips.where(city_id: city.id).where('start_at > ? AND end_at < ?', segment.start_at, segment.end_at)

      if !trips.blank?
        trip = trips.first
      else
        trip = user.trips.create(city_id: city.id)
      end
    end

    reservation_segment.city_id = city.id
    reservation_segment.start_at = segment.start_at
    reservation_segment.end_at = segment.end_at
    reservation_segment.trip = trip
    reservation_segment.segment_type = segment.segment_type

    reservation_segment.save
  end

  def update_trip_completeness
    self.completed = self.start_at.present? && self.end_at.present?
  end
end
