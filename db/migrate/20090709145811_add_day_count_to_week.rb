class AddDayCountToWeek < ActiveRecord::Migration
  def self.up
    add_column :weeks, :day_count, :integer
  end

  def self.down
    remove_column :weeks, :day_count
  end
end
