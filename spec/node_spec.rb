require 'spec_helper'
 
describe Node do

	before :all do
		default_properties = { 
	   		:r => 256,
	   		:g => 256,
	   		:b => 256,
	   		:x => 10,
	   		:y => 20
	   }
	   @node = Node.new default_properties
	end

	describe "#create" do

		it "testing properties must to be the same of object parameter in this case Person" do

			person = Person.new "Tom", 26
			
			@node.create person

		  	@node.properties[:name].should eql "Tom"
		  	
		  	@node.properties[:age].should eql 26

		end
		          
	end

	describe "#retrieve" do

		it "when you wanto to get a neo node" do

			person_node = @node.retrieve

			person_node[:name].should eql "Tom"
		end
	end


end
