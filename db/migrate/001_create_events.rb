class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.column    :name,      :string,    :limit => 200
      t.column    :slug,      :string,    :limit => 16
      t.column    :starts_on, :date
      t.column    :ends_on,   :date
      t.column    :contact,   :string,    :limit => 200
      t.column    :email,     :string,    :limit => 200
    end
  end

  def self.down
    drop_table :events
  end
end
