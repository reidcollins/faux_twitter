namespace :db do
	desc "fill database with sample data (to test pagination"
	task populate: :environment do
		admin = User.create!(name: "reid admin",
								 email: "reid1@collins.com",
								 password: "franz13",
								 password_confirmation: "franz13")
		admin.toggle!(:admin)
		99.times do |n|
			name = Faker::Name.name
			email = "example-#{n+1}@fake.com"
			password = "password"
			User.create!(name: name, email: email, password: password,
									 password_confirmation: password )
		end
	end
end

#rake db:reset
#rake db:populate
#rake db:test:prepare