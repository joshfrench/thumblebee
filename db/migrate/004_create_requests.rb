class CreateRequests < ActiveRecord::Migration
  def self.up
    create_table :requests do |t|
      t.column  :person_id,   :int,   :limit => 4
      t.column  :ride_id,     :int,   :limit => 4
      t.column  :seats,       :int,   :limit => 4
    end
  end

  def self.down
    drop_table :requests
  end
end
