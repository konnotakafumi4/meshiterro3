class PostImage < ApplicationRecord
  has_one_attached :image
  blongs_to :user
end
