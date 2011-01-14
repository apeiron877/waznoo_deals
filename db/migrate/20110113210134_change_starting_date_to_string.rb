class ChangeStartingDateToString < ActiveRecord::Migration
  def self.up
  	change_column :deals, :starting_date, :string
  	
  	add_index :deals, :starting_date
  end

  def self.down
  	change_column :deals, :starting_date, :integer
  	
  	delete_index :deals, :starting_date
  end
end
