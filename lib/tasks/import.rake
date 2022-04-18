task :import => :environment do
  # For assignment purposes, clean all data
  clean_stored_data
  # Create random user as reservations owner
  create_random_user
  # Open file and parse text
  raw_data = get_raw_data(Rails.root.join('public','data.txt'))
  
  NormalizeRawTextInput.new(raw_data).perform.each do |segments|
    segments.each_with_index do |segment|
        parsed_segment = ParsedSegment.new(segment, @user)

        Trip.append_to_existing_or_create_new_trip(parsed_segment, @user)
      end
  end  
end

def clean_stored_data
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