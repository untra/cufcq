class Instructor < ActiveRecord::Base
has_many :fcqs
has_many :courses, through: :fcqs
validates :instructor_first, :instructor_last, presence: true
validates_uniqueness_of :instructor_first, scope: [:instructor_last]
#respect
#availability
#effectiveness
#overall
#passrate
#classes taught
#students taught
#records since


def full_name
	return "#{self.instructor_first} #{self.instructor_last}"
end

def department
  self.fcqs.pluck(:subject).mode
end

def instructor_group
  self.fcqs.pluck(:instructor_group).mode
end

def started_teaching
  Fcq.semterm_from_int(self.fcqs.minimum(:yearterm))
end

def average_respect
  self.fcqs.average(:respect).round(1)
end

def average_availability
  self.fcqs.average(:availability).round(1)
end

def average_effectiveness
  self.fcqs.average(:effectiveness).round(1)
end

def total_requested
  self.fcqs.sum(:forms_requested) 
end

def total_returned
  self.fcqs.sum(:forms_returned)
end

def requested_returned_ratio
  total_requested.to_f / total_returned
end

def average_percentage_passed_float
  total = 0.0
  self.fcqs.compact.each {|x| next if x.float_passed < 0.0; total += x.float_passed}
  count = courses_taught
  if count == 0
    return 1.0 
  else
    return (total.to_f / count.to_f)
  end
end

def pass_rate_string
  val = (average_percentage_passed_float * 100).round(0)
  val = [val, 100].min
  val = [val, 0].max
  string = val.round
  return "#{string}%"
end 

def average_instructor_overall
  return self.fcqs.average(:instructor_overall).round(1)
end

def courses_taught
  return self.fcqs.where('percentage_passed IS NOT NULL').count
end

attr_reader :semesters, :overall_data, :availability_data, :respect_data, :effectiveness_data, :categories

def overall_query
  overalls = self.fcqs.group("yearterm").average(:instructor_overall)
  avails = self.fcqs.group("yearterm").average(:availability)
  effects = self.fcqs.group("yearterm").average(:effectiveness)
  respects = self.fcqs.group("yearterm").average(:respect)
  @semesters = []
  @overall_data = []
  @availability_data = [] 
  @respect_data = [] 
  @effectiveness_data = [] 
  #records.each {|k,v| fixedrecords[Fcq.semterm_from_int(k)] = v.to_f.round(1)}
  overalls.each {|k,v| @overall_data << [k,v.to_f.round(1)]}
  avails.each {|k,v| @availability_data << [k,v.to_f.round(1)]}
  effects.each {|k,v| @effectiveness_data << [k,v.to_f.round(1)]}
  respects.each {|k,v| @respect_data << [k,v.to_f.round(1)]}
  #@chart_data = fixedrecords.values
  puts @chart_data
end








end

