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

  def self.segment_append_or_create(segment, user)
    # This method gets a single reservation segment 
    # and associates to a new or already created Trip

    reservation_segment = user.reservation_segments.build
    reservation_segment.origin = segment.origin 
    
    if segment.transportation?
      reservation_segment.destination = segment.destination

      if segment.aller?
        reservation_segment.rank = 0
        city = City.find_or_create_by(code: segment.destination)
        trip = user.trips.find_or_initialize_by(city_id: city.id, 
                                                completed: false)
        trip.start_at = segment.start_at
        
      elsif segment.retour?
        reservation_segment.rank = 1000000
        city = City.find_or_create_by(code: segment.origin)
        trip = user.trips.find_or_initialize_by(city_id: city.id, 
                                                completed: false)
        trip.end_at = segment.end_at
        
      end

    elsif segment.hotel?
      reservation_segment.rank = 500000
      city = City.find_or_create_by(code: segment.origin)
      trips = user.trips.where('city_id = ? AND CAST(start_at AS DATE) >= ? AND CAST(end_at AS DATE) <= ?', 
                                city.id, 
                                segment.start_at, 
                                segment.end_at)
      
      if !trips.blank? && trips.size > 1
        log("1 trip expected, got more")

      elsif !trips.blank? && trips.size == 1
        trip = trips.first

      else
        trip = user.trips.new(city_id: city.id)

      end
    end

    trip.save
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
