class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.column  :name,        :string,    :limit => 255
      t.column  :end_date,    :datetime
      t.column  :contact_id,  :int,       :limit => 4
    end
  end

  def self.down
    drop_table :events
  end
end
