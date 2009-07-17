class AddTypeToEngineer < ActiveRecord::Migration
  def self.up
    add_column :engineers, :type, :string
  end

  def self.down
    remove_column :engineers, :type
  end
end
