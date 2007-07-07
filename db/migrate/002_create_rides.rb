class CreateRides < ActiveRecord::Migration
  def self.up
    create_table :rides do |t|
      t.column    :event_id,    :integer
      t.column    :driver,      :string,    :limit => 200
      t.column    :email,       :string,    :limit => 200
      t.column    :phone,       :string,    :limit => 36
      t.column    :location,    :string,    :limit => 255
      t.column    :seats,       :integer,   :limit => 1
      t.column    :comment,     :text
      t.column    :created_at,  :datetime
      t.column    :modified_at, :datetime
      t.column    :auth,        :string,    :limit => 36
    end
  end

  def self.down
    drop_table :rides
  end
end
