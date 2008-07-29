class AddAnonymailToUsers < ActiveRecord::Migration
  def self.up
    add_column :rides, :anonymail, :string, :limit => 32
  end

  def self.down
    remove_column :rides, :anonymail
  end
end
