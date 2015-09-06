task :campus_correction => :environment do
  Instructor.find_each do |x|
    begin
      puts x.name
      campus = x.fcqs.pluck(:campus).mode
      if x.campus != nil
        puts "skipped"
        next
      end
      # puts x.id
      x.update_column(:campus, campus)
      # puts "attribute updated"
      x.save()
    rescue Exception => e
      puts "rescued - " + e.message
    end
  end
end
