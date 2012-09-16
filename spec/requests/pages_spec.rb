require 'spec_helper'

describe "Pages" do
  
	describe "Home page" do

		it "should have the content 'fauxtwitter'" do
			visit '/pages/home'
			page.should have_selector('h1', :text => 'fauxtwitter')
		end

		it "should have the correct title" do
			visit '/pages/home'
			page.should have_selector('title',
										:text => 'fauxtwitter | home')
		end
	end

	describe "Help page" do
		it "should have the content 'Help'" do
			visit '/pages/help'
			page.should have_selector('h1', :text => 'Help')
		end

		it "should have the correct title" do
			visit '/pages/help'
			page.should have_selector('title',
										:text => 'fauxtwitter | help')
		end
	end

	describe "About page"  do
		it "should have the content 'About us'" do
			visit '/pages/about'
			page.should have_selector('h1', :text => 'About us')
		end

		it "should have the correct title" do
			visit '/pages/about'
			page.should have_selector('title',
										:text => 'fauxtwitter | about')
		end
	end

	describe "Contact page" do
		it "should have the content 'Contact'" do
			visit '/pages/contact'
			page.should have_selector('h1', :text => 'Contact')
		end

		it "should have the correct title" do
			visit '/pages/contact'
			page.should have_selector('title',
										:text => 'contact' )
		end
	end
end
