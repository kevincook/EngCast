class CreateEngineers < ActiveRecord::Migration
  def self.up
    create_table :engineers do |t|
      t.string :firstname
      t.string :lastname

      t.timestamps
    end
  end

  def self.down
    drop_table :engineers
  end
end
