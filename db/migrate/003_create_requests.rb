class CreateRequests < ActiveRecord::Migration
  def self.up
    create_table :requests do |t|
    end
  end

  def self.down
    drop_table :requests
  end
end
