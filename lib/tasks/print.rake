task :print => :environment do
  Print.new(Trip.all).perform
end