class Manager < ActiveRecord::Base
  has_many :engineers
  
  def display_name
    "#{last_name}, #{first_name}"
  end
end
