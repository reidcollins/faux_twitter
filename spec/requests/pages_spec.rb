require 'spec_helper'

describe "Pages" do

	subject { page }
  
	describe "Home page" do

		before { visit root_path }

		it { should have_selector('h1', :text => 'fauxtwitter') }
		it { should have_selector('title', :text => proper_title('')) }
		it { should_not have_selector('title', :text => '| home') }

		describe "for signed-in users" do
			let(:user) { FactoryGirl.create(:user) }
			before do
				FactoryGirl.create(:micropost, :user => user, :content => "testtest1")
				FactoryGirl.create(:micropost, :user => user, :content => "testtest2")
				sign_in user
				visit root_path
			end

			it "should render the user's feed" do
				user.feed.each do |item|
					page.should have_selector("li##{item.id}", :text => item.content)
				end
			end


			describe "follower/following counts" do
				let(:other_user) { FactoryGirl.create(:user) }
				before do
					other_user.follow!(user)
					visit root_path
				end

				it { should have_link("0 following", :href => following_user_path(user)) }
				it { should have_link("1 followers", :href => followers_user_path(user)) }
			end
		end
	end

	describe "Help page" do

		before { visit help_path }

		it { should have_selector('h1', :text => 'Help') }
		it { should have_selector('title', :text => proper_title('help')) }
	end

	describe "About page"  do

		before { visit about_path }

		it { should have_selector('h1', :text => 'About us') }
		it { should have_selector('title', :text => proper_title('about')) }
	end

	describe "Contact page" do

		before { visit contact_path }

		it { should have_selector('h1', :text => 'Contact') }
		it { should have_selector('title', :text => proper_title('contact')) }
	end

	it "should have the correct links in the layout" do
		visit root_path
		click_link "Sign in"
		page.should have_selector('title', :text => proper_title('signin'))
		click_link "About"
		page.should have_selector('title', :text => proper_title('about'))
		click_link "Help"
		page.should have_selector('title', :text => proper_title('help'))
		click_link "Contact"
		page.should have_selector('title', :text => proper_title('contact'))
		click_link "Home"
		page.should have_selector('title', :test => proper_title(''))
		click_link "Sign up now!"
		page.should have_selector('title', :text => proper_title('signup'))
	end
end
