class CreateCoupons < ActiveRecord::Migration
  def self.up
    create_table :coupons do |t|
      t.string :name
      t.string :company
      t.string :expires_on
      t.string :fine_print
      t.integer :days_to_regen
      t.string :redeemable_at
      t.timestamps
    end
    add_index :coupons, :id
  end

  def self.down
    drop_table :coupons
  end
end
