class RemoveImageIdFromPostComments < ActiveRecord::Migration[6.1]
  def change
    remove_column :post_comments, :image_id, :integer
  end
end
