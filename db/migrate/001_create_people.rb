class CreatePeople < ActiveRecord::Migration
  def self.up
    create_table :people do |t|
      t.column  :name,  :string,  :limit => 100
      t.column  :email, :string,  :limit => 100
      t.column  :phone, :string,  :limit => 24 
    end
  end

  def self.down
    drop_table :people
  end
end
