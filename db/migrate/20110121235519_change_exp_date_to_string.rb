class ChangeExpDateToString < ActiveRecord::Migration
  def self.up
    change_column :deals, :expires, :string
  end
  

  def self.down
    change_column :deals, :expires, :integer
  end



end


