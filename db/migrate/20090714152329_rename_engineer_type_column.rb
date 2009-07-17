class RenameEngineerTypeColumn < ActiveRecord::Migration
  def self.up
    rename_column "engineers", "type", "role"
  end

  def self.down
    rename_column "engineers", "role", "type"
  end
end
