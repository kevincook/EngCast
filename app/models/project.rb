class Project < ActiveRecord::Base
  has_many :assignments
  has_many :engineers, :through =>:assignments
  has_many :weeks, :through => :assignments
  
  COLUMN_ENGINEER_ID = 0
  COLUMN_ENGINEER_LASTNAME = 1
  COLUMN_ENGINEER_FIRSTNAME = 2
  COLUMN_PROJECT_ID = 3
  COLUMN_PROJECT_NAME = 4
  
  def software_engineers
    engineers.find_all_by_role('SW')
  end
  
  def qa_engineers
    engineers.find_all_by_role('QA')
  end
  
  def crosstab
    query = "select engineers.id, engineers.lastname, engineers.firstname, projects.id, COALESCE( projects.name,'UA') from engineers, weeks left outer join assignments on assignments.week_id = weeks.id and assignments.engineer_id = engineers.id left outer join projects on projects.id = assignments.project_id order by engineers.role, engineers.lastname, engineers.firstname, weeks.number"
    dataset = ActiveRecord::Base.connection.execute(query)
    
    result = []
        
    if dataset.size > 0
      rec = { :current_engineer => dataset[0][COLUMN_ENGINEER_ID], :name => "#{dataset[0][COLUMN_ENGINEER_LASTNAME]}, #{dataset[0][COLUMN_ENGINEER_FIRSTNAME]}", :week_data => []}
      dataset.each do | record |
        if record[COLUMN_ENGINEER_ID] != rec[:current_engineer]
          result << rec
          rec = { :current_engineer => record[COLUMN_ENGINEER_ID], :name => "#{record[COLUMN_ENGINEER_LASTNAME]}, #{record[COLUMN_ENGINEER_FIRSTNAME]}", :week_data => []}
        end
        if record[COLUMN_PROJECT_ID] == id
          rec[:week_data] << { :id => record[COLUMN_PROJECT_ID], :name => "X" }
        else
          rec[:week_data] << { :id => record[COLUMN_PROJECT_ID], :name => ""}
        end
      end
    end
    
    result    
  end
end
