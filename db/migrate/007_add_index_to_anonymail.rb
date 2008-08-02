class AddIndexToAnonymail < ActiveRecord::Migration
  def self.up
    add_index :rides, :anonymail
  end

  def self.down
    remove_index :rides, :anonymail
  end
end
