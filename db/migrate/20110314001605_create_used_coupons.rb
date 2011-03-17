class CreateUsedCoupons < ActiveRecord::Migration
  def self.up
    create_table :used_coupons do |t|
      t.integer :user_id
      t.integer :coupon_id

      t.timestamps
    end
    add_index :used_coupons, :user_id
    add_index :used_coupons, :coupon_id
  end

  def self.down
    drop_table :used_coupons
  end
end
