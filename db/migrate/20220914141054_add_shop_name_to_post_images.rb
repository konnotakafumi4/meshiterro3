class AddShopNameToPostImages < ActiveRecord::Migration[6.1]
  def change
    add_column :post_images, :shop_name, :string
  end
end
