require 'spec_helper'
 
describe Link do

	describe "#create_link" do

		it "testing the creation of a relation" do
			
			default_properties = { 
		   		:r => 256,
		   		:g => 256,
		   		:b => 256,
		   		:x => 10,
		   		:y => 20
		    }
		   	source = Node.new default_properties
		   	target = Node.new default_properties


			person_source = Person.new "Tom", 26

			person_target = Person.new "Manu", 26
			
			source.create person_source

			target.create person_target

			link = Link.new source.retrieve, target.retrieve

			link.create_link

			created_link = link.link

			created_link.should_not eql nil
		end
	end
end
