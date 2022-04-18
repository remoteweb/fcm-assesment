task :import => :environment do
  Import.new(Rails.root.join('public','data.txt')).perform
end