class User < ActiveRecord::Base
	attr_accessible :email, :name, :password, :password_confirmation

	#User.microposts.build/create methods
	has_many :microposts, :dependent => :destroy
	has_many :relationships, :foreign_key => "follower_id", :dependent => :destroy
	has_many :followed_users, :through => :relationships, :source => :followed
	has_many :reverse_relationships, :foreign_key => "followed_id",
																	 :class_name => "Relationship",
																	 :dependent => :destroy
	has_many :followers, :through => :reverse_relationships, :source => :follower

	has_secure_password

	before_save { |user| user.email = user.email.downcase}
	before_save :create_remember_token

	VALID_EMAIL = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, :presence => true, :format => { :with => VALID_EMAIL },
										:uniqueness => { :case_sensitive => false }
	validates :name,  :presence => true, :length => { :maximum => 50 }
	validates :password, :length => { :minimum => 6 }
	validates :password_confirmation, :presence => true

	def following?(other_user)
		self.relationships.find_by_followed_id(other_user.id)
	end

	def follow!(other_user)
		self.relationships.create!(:followed_id => other_user.id)
	end

	def unfollow!(other_user)
		self.relationships.find_by_followed_id(other_user.id).destroy
	end

	def feed
		#this is only a protofeed
		#self.microposts
		#Micropost.where("user_id = ?", id)
		Micropost.from_users_followed_by(self)
	end

	private

		def create_remember_token
			self.remember_token = SecureRandom.urlsafe_base64
			
		end

end
