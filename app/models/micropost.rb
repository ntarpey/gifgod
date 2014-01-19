class Micropost < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order('created_at DESC') }
  #DESC means descending; posts will show in this order.

  validates :content, presence: true, length: { maximum: 140 }

  validates :user_id, presence: true
end
