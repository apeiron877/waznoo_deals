class CreateDeals < ActiveRecord::Migration
  def self.up
    create_table :deals do |t|
      t.string :name
      t.integer :starting_date
      t.integer :days_available
      t.integer :price
      t.integer :value
      t.integer :num_available
      t.integer :num_purchased
      t.integer :num_needed_to_unlock
      t.string :blurb
      t.string :expires
      t.string :company
      t.string :location

      t.timestamps
    end
    add_index :deals, :starting_date
  end

  def self.down
    drop_table :deals
  end
end
