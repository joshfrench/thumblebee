class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.column    :name,      :string,    :limit => 200
      t.column    :slug,      :string,    :limit => 16
      t.column    :starts_on, :date
      t.column    :location,  :string,    :limit => 200
      t.column    :contact,   :string,    :limit => 200
      t.column    :email,     :string,    :limit => 200
      t.column    :created_at, :datetime
    end
  end

  def self.down
    drop_table :events
  end
end
