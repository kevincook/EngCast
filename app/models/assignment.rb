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

  def self.new_rec(row)
    rec = {}
    rec[:engineer_id] = row[COLUMN_ENGINEER_ID]
    rec[:engineer_lastname] = row[COLUMN_ENGINEER_LASTNAME]
    rec[:engineer_firstname] = row[COLUMN_ENGINEER_FIRSTNAME]
    rec[:engineer_displayname] = "#{row[COLUMN_ENGINEER_LASTNAME]}, #{row[COLUMN_ENGINEER_FIRSTNAME]}"    
    rec
  end
  
  def self.crosstab    		
    dataset = ActiveRecord::Base.connection.execute("select engineers.id, engineers.lastname, engineers.firstname, projects.id, COALESCE( projects.name,'UA') from engineers, weeks left outer join assignments on assignments.week_id = weeks.id and assignments.engineer_id = engineers.id left outer join projects on projects.id = assignments.project_id order by engineers.role, engineers.lastname, engineers.id, weeks.number")
    
    result = {}
    
    rows = []
        
    if dataset.size > 0
      row = dataset[0]
      
      debugger
      
      rec = new_rec(row)
      week = 0
      
      dataset.each do | record |
        if record[COLUMN_ENGINEER_ID] != rec[:engineer_id]
          rows << rec
          rec = new_rec(record)
          week = 0
        end
        h2 = {"week#{week}".intern => record[COLUMN_PROJECT_NAME]}
        rec = rec.merge(h2)
        week = week + 1
      end
    end
    
    result[:total] = rows.size
    result[:rows] = rows
    result
  end
end
