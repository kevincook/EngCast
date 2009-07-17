class AddManagerToEngineer < ActiveRecord::Migration
  def self.up
    add_column :engineers, :manager_id, :integer
  end

  def self.down
    remove_column :engineers, :manager_id
  end
end
