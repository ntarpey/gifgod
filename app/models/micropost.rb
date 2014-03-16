class Micropost < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order('created_at DESC') }
  #DESC means descending; posts will show in this order.

  validates :content, presence: true,  format: {
      with: %r{\.(gif|jpg|png)\z}i,
      message: 'links need to end in .gif'
  }

  # deleted: length: { maximum: 140 }, no need anymore for limits on content length.

  validates :user_id, presence: true

  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id"
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id",
          user_id: user)
  end

end
