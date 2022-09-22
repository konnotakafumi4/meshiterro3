class RemoveImageIdFromPostImage < ActiveRecord::Migration[6.1]
  def change
    remove_column :post_images, :image_id, :integer
  end
end
#コマンドミス
