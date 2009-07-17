class Assignment < ActiveRecord::Base
  belongs_to :engineer
  belongs_to :project
  belongs_to :week
  
  validates_uniqueness_of :engineer_id, :scope => [:project_id, :week_id]
  
  COLUMN_ENGINEER_ID = 0
  COLUMN_ENGINEER_LASTNAME = 1
  COLUMN_ENGINEER_FIRSTNAME = 2
  COLUMN_PROJECT_ID = 3
  COLUMN_PROJECT_NAME = 4
  
  def self.crosstab    		
    dataset = ActiveRecord::Base.connection.execute("select engineers.id, engineers.lastname, engineers.firstname, projects.id, COALESCE( projects.name,'UA') from engineers, weeks left outer join assignments on assignments.week_id = weeks.id and assignments.engineer_id = engineers.id left outer join projects on projects.id = assignments.project_id order by engineers.role, engineers.lastname, engineers.firstname, weeks.number")
    
    result = []
        
    if dataset.size > 0
      rec = { :current_engineer => dataset[0][COLUMN_ENGINEER_ID], :name => "#{dataset[0][COLUMN_ENGINEER_LASTNAME]}, #{dataset[0][COLUMN_ENGINEER_FIRSTNAME]}", :week_data => []}
      dataset.each do | record |
        if record[COLUMN_ENGINEER_ID] != rec[:current_engineer]
          result << rec
          rec = { :current_engineer => record[COLUMN_ENGINEER_ID], :name => "#{record[COLUMN_ENGINEER_LASTNAME]}, #{record[COLUMN_ENGINEER_FIRSTNAME]}", :week_data => []}
        end
        rec[:week_data] << { :id => record[COLUMN_PROJECT_ID], :name => record[COLUMN_PROJECT_NAME] }
      end
    end
    
    result
  end
end
