class Engineer < ActiveRecord::Base
  has_many :assignments
  has_many :projects, :through => :assignments
  has_many :weeks, :through => :assignments
  belongs_to :manager
  
  def display_name
    "#{lastname}, #{firstname}"
  end
  
  def self.qa_engineers
    Engineer.find_all_by_role('QA', :order => :lastname)
  end
  
  def self.sw_engineers
    Engineer.find_all_by_role('SW', :order => :lastname)
  end
end
