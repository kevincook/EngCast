class CreateAssignments < ActiveRecord::Migration
  def self.up
    create_table :assignments do |t|
      t.integer :engineer_id
      t.integer :project_id
      t.integer :week_id
      t.timestamps
    end    
  end

  def self.down
    drop_table :assignments
  end
end
