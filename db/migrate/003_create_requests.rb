class CreateRequests < ActiveRecord::Migration
  def self.up
    create_table :requests do |t|
      t.column  :ride_id,     :integer
      t.column  :name,        :string,    :limit => 200
      t.column  :email,       :string,    :limit => 200
      t.column  :phone,       :string,    :limit => 36
      t.column  :seats,       :integer,   :limit => 1
      t.column  :comment,     :text
    end
  end

  def self.down
    drop_table :requests
  end
end
