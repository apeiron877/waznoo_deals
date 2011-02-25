class AddBarcodeUrlToCoupons < ActiveRecord::Migration
  def self.up
    add_column :coupons, :barcode_url, :string
  end

  def self.down
    remove_column :coupons, :barcode_url
  end
end
