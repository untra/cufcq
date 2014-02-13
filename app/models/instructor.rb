class Instructor < ActiveRecord::Base
has_many :fcqs
has_many :courses, through: :fcqs

#respect
#availability
#effectiveness
#overall
#passrate
#classes taught
#students taught
#records since


def average_respect
  self.fcqs.average(:respect)
end

def average_availability
  self.fcqs.average(:availability)
end

def average_effectiveness
  self.fcqs.average(:effectiveness)
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

def average_percentage_passed
  self.fcqs.average(:float_passed)
end

def average_instructor_overall
  self.fcqs.average(:instructor_overall)
end

def courses_taught
  self.fcqs.count
end



end
