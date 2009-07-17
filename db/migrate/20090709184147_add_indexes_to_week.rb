class AddIndexesToWeek < ActiveRecord::Migration
  def self.up
    add_index :weeks, :startdate, :unique=>true
    add_index :weeks, :enddate, :unique=>true
  end

  def self.down
    remove_index :weeks, :startdate
    remove_index :weeks, :enddate
  end
end
