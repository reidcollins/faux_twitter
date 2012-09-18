require 'spec_helper'

describe "Userpages" do
  
  subject { page }

  describe "signup page" do
  	before { visit signup_path }

  	it { should have_selector('h1', :text => 'Sign up') }
  	it { should have_selector('title', :text => proper_title('signup')) }
  end

end
