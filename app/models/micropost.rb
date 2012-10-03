class Micropost < ActiveRecord::Base
  attr_accessible :content
  belongs_to :user #Micropost.user method

  validates :user_id, :presence => true
  validates :content, :presence => true, :length => { :maximum => 140 }

  default_scope :order => 'microposts.created_at DESC'

  def self.from_users_followed_by(user)
  	#where("user_id = ?", user.id)
  	#following_ids = user.followed_users.map(&:id).join(', ')
  	#following_ids = user.followed_users.map(&:id)
  	#followed_user_ids = user.followed_user_ids
  	followed_user_ids = "SELECT followed_id FROM relationships
  											 WHERE follower_id = :user_id"
  	where("user_id IN (#{followed_user_ids}) OR user_id = :user_id",
  	      { :user_id => user.id })

  	#SELECT "microposts".* FROM "microposts"
  	#WHERE (user_id IN (SELECT followed_id FROM relationships 	
    #WHERE follower_id = 1) OR user_id = 1)
		#ORDER BY microposts.created_at DESC
  end
end
