include ApplicationHelper

#moved the code below into spec/helpers/application_helper.rb
#returns full title on per page basis
#def proper_title(page_title)
#	base_title = 'fauxtwitter'

#	if page_title.empty?
#		base_title
#	else
#		"#{base_title} | #{page_title}"
#	end

def sign_in(user)
	visit signin_path
	fill_in "Email",    :with => user.email
	fill_in "Password", :with => user.password
	click_button "Sign in"

	#sign in when not usering Capybara
	cookies[:remember_token] = user.remember_token
end