class CreateRides < ActiveRecord::Migration
  def self.up
    create_table :rides do |t|
    end
  end

  def self.down
    drop_table :rides
  end
end
