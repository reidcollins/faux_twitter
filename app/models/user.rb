class User < ActiveRecord::Base
	attr_accessible :email, :name, :password, :password_confirmation

	#User.microposts.build/create methods
	has_many :microposts, :dependent => :destroy
	has_secure_password

	before_save { |user| user.email = user.email.downcase}
	before_save :create_remember_token

	VALID_EMAIL = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, :presence => true, :format => { :with => VALID_EMAIL },
										:uniqueness => { :case_sensitive => false }
	validates :name,  :presence => true, :length => { :maximum => 50 }
	validates :password, :length => { :minimum => 6 }
	validates :password_confirmation, :presence => true

	def feed
		#this is only a protofeed
		#self.microposts
		Micropost.where("user_id = ?", id)
	end

	private

		def create_remember_token
			self.remember_token = SecureRandom.urlsafe_base64
			
		end

end
