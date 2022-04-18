class Import
  def initialize(path)
    @path = path
  end

  def perform
      # For assignment purposes, clean all data
      clean_db
      # Create random user as reservations owner
      create_random_user
      # Open file and parse text
      raw_data = get_raw_data(@path)

      NormalizeText.new(raw_data).perform
        .each do |segments|
          segments.each_with_index do |segment|
              parsed_segment = ParsedSegment.new(segment, @user)
      
              Trip.segment_append_or_create(parsed_segment, @user)
            end
        end  
  end

  private

  def clean_db
    User.delete_all
    City.delete_all
    Trip.delete_all
    ReservationSegment.delete_all
  end
  
  def get_raw_data(file_path)
    file = File.open(file_path)
    raw_data = file.read
    file.close
  
    return raw_data
  end
  
  def create_random_user
    @user = User.create(
              name: Faker::Name.name,
              city: City.find_or_create_by(code: 'SVQ')
            ) 
  end
  
  def convert_to_segments_array data
    Arrary(data)
  end
end