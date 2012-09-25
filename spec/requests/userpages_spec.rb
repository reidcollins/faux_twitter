require 'spec_helper'

describe "Userpages" do
  
  subject { page }

  describe "signup page" do
  	before { visit signup_path }

  	it { should have_selector('h1', :text => 'Sign up') }
  	it { should have_selector('title', :text => proper_title('signup')) }
  end

  describe "profile page" do
  	let(:user) { FactoryGirl.create(:user) }
  	before { visit user_path(user) }
  	it { should have_selector('h1', :text => user.name) }
  	it { should have_selector('title', :text => user.name) }
  end

  describe "signup" do
  	before { visit signup_path }
    let(:submit) { "Create my account" }

  	describe "with invalid information" do
  		it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)

  			#old_count = User.count
  			#click_button "Create my account"
        #click_button submit
  			#new_count = User.count
  			#new_count.should == old_count
			end

      describe "after submission" do
        before { click_button submit }

        it { should have_selector('title', :text => 'signup') }
        it { should have_content('error') }
        it { should_not have_content('Password digest') }
        #change config/locales/en.yml
      end
  	end

  	describe "with valid information" do
      before do
        fill_in "Name",         :with => "reid1"
        fill_in "Email",        :with => "reid1@collins.com"
        fill_in "Password",     :with => "franz13"
        fill_in "Confirmation", :with => "franz13"
      end

  		it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
        #old_count = User.count
        #click_button "Create my account"
        #click_button submit
        #new_count = User.count
        #new_count.should == old_count + 1
  		end

      describe "after saving a user" do
        before { click_button submit }

        let(:user) { User.find_by_email("reid1@collins.com") }
        it { should have_selector('title', :text => user.name) }
        it { should have_selector('div.alert.alert-success'), :text => "Welcome" }
        it { should have_link('Sign out') }
      end
  	end
  end

  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit edit_user_path(user) }

    describe "edit page" do
      
      it { should have_selector('h1', :text => "Update your profile") }
      it { should have_selector('title', :text => "edit profile") }
      it { should have_link('change', :href => 'http://gravatar.com/emails') }
    end

    describe "with invalid information" do
      before { click_button "Save changes" }

      it { should have_selector('div.alert.alert-error'), :text => "errors" }
    end

    describe "with valid information" do
      let(:new_name) { "new name" }
      let(:new_email) { "new@example.com" }
      before do
        fill_in "Name",         :with => new_name
        fill_in "Email",        :with => new_email
        fill_in "Password",     :with => user.password
        fill_in "Confirmation", :with => user.password
        click_button "Save changes"
      end

      it { should have_selector('title', :text => new_name) }
      it { should have_link('Sign out', :href => signout_path) }
      it { should have_selector('div.alert.alert-success') }
      it { user.reload.name.should  == new_name }
      it { user.reload.email.should == new_email }
    end
  end
end
