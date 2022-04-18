class ParsedSegment
  attr_reader     :start_at, 
                  :end_at,
                  :destination,
                  :origin


  def initialize(segment, user)
    @segment = segment
    @user = user
  end

  def hotel?
    @segment.include?('Hotel')
  end

  def transportation?
    self.flight? || self.train?
  end
  
  def segment_type
    split_string_to_array(@segment)[0]
  end
  
  def flight?
    @segment.include?('Flight')

  end
  
  def train?
    @segment.include?('Train')
  end

  def destination
    if self.transportation?
      split_string_to_array(@segment)[5]
    elsif self.hotel?
      false
    end
  end

  def origin
    split_string_to_array(@segment)[1]
  end


  def aller?
    self.transportation? && self.destination != @user.city.code
  end

  def retour?
    self.transportation? && self.destination == @user.city.code
  end

  def start_at
    if self.hotel?
      DateTime.parse("#{split_string_to_array(@segment)[2]} - 12:00")

    elsif self.transportation?
      DateTime.parse("#{split_string_to_array(@segment)[2]},
                      #{split_string_to_array(@segment)[3]}")
    end
  end

  def end_at
    if self.hotel?
      DateTime.parse("#{split_string_to_array(@segment)[4]} - 12:00")

    elsif self.transportation?
      if split_string_to_array(@segment)[7].present?
        DateTime.parse("#{split_string_to_array(@segment)[6]} - #{split_string_to_array(@segment)[7]}")
      else
        DateTime.parse("#{self.start_at.to_date} - #{split_string_to_array(@segment)[6]}")
      end
    end
  end

  private

  def split_string_to_array(data)
    data.split(' ')

  end
end
