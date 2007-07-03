class CreateRides < ActiveRecord::Migration
  def self.up
    create_table :rides do |t|
      t.column  :event_id,        :int,     :limit => 4
      t.column  :driver_id,       :int,     :limit => 4
      t.column  :location,        :string,  :limit => 255
      t.column  :seats_available, :int,     :limit => 1
      t.column  :departing,       :string,  :limit => 255
      t.column  :returning,       :string,  :limit => 255
      t.column  :auth,            :string,  :limit => 32
    end
  end

  def self.down
    drop_table :rides
  end
end
