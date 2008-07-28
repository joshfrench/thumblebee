class RemovePhoneFromRides < ActiveRecord::Migration
  def self.up
    remove_column :rides, :phone
  end

  def self.down
    add_column :rides, :phone, :string, :limit => 36
  end
end
