class AddPhotoToCoupons < ActiveRecord::Migration
  def self.up
    add_column :coupons, :image_url, :string
  end

  def self.down
    remove_column :coupons, :image_url
  end
end
