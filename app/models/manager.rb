class Manager < ActiveRecord::Base
  has_many :engineers
  
  def display_name
    "#{last_name}, #{first_name}"
  end
  
  def self.grid_data
    managers = find(:all, :order=>'last_name')
    result = {}
    result[:total] = managers.size
    result[:rows] = managers.collect{|u|{
      :id => u.id,
      :last_name => u.last_name,
      :first_name => u.first_name,
      :created_at => u.created_at,
      :updated_at => u.updated_at
    }}
    result
  end
end
