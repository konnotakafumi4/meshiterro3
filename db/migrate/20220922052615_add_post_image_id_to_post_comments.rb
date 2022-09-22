class AddPostImageIdToPostComments < ActiveRecord::Migration[6.1]
  def change
    add_column :post_comments, :post_image_id, :integer
  end
end
