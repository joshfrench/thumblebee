class CreateRiders < ActiveRecord::Migration
  def self.up
    create_table :riders do |t|
      t.column  :person_id,   :int, :limit => 4
      t.column  :ride_id,     :int, :limit => 4
      t.column  :seats,       :int, :limit => 4
    end
  end

  def self.down
    drop_table :riders
  end
end
