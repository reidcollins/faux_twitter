require 'spec_helper'

describe ApplicationHelper do

	describe "proper title" do
		it "should include the page title" do
			proper_title('foo').should =~ /foo/
		end

		it "should include the base title" do
			proper_title('foo').should =~ /^fauxtwitter/
		end

		it "should not include a bar on the home page" do
			proper_title('').should_not =~ /\|/
		end
	end	
end