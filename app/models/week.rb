class Week < ActiveRecord::Base
  has_many :assignments
  has_many :eningeers, :through => :assignments
  has_many :projects, :through => :assignments
  
  def self.grid_data
    weeks = find(:all, :order=>'startdate')
    result = {}
    result[:total] = weeks.size
    result[:rows] = weeks.collect{|u|{
      :id => u.id,
      :number => u.number,
      :startdate => u.startdate,
      :enddate => u.enddate,
      :day_count => u.day_count,
      :created_at => u.created_at,
      :updated_at => u.updated_at
    }}
    result
  end
end
