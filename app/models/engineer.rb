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
  
  def self.grid_data
    engineers = find(:all, :order => 'lastname')
    
    result = {}
    
    result[:total] = engineers.size
    result[:rows] = engineers.collect{|u|{ 
      :id => u.id,
      :updated_at => u.updated_at,
      :created_at => u.created_at,
      :manager_id => u.manager_id,
      :role => u.role,
      :lastname => u.lastname,
      :firstname => u.firstname
    }}
    result
  end
end

