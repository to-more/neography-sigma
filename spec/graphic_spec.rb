require 'spec_helper'
 
describe Graphic do

	before :all do
			default_properties = { 
		   		:r => 256,
		   		:g => 256,
		   		:b => 256,
		   		:x => 10,
		   		:y => 20
			}
			source = Node.new default_properties
			target = Node.new default_properties

			person = Person.new "Tom", 26
			person_target = Person.new "Jack", 22
			
			source.create person
			target.create person_target

			link = Link.new source.retrieve, target.retrieve
			link.create_link

			@nodes = Array.new
			@nodes << source.retrieve
			@nodes << target.retrieve

			@edges = Array.new
			@edges << link.link
	end		

	describe "#create_gexf" do

		it "testing the creation of gexf file" do
			
			graphic = Graphic.new

			xml = graphic.create_gexf

			value = xml != nil
			value.should eql true

			File.open("spec/spec.gexf", 'w') { |file| file.write(xml.target!) }
		end
	end


	describe "#json_nodes" do

		it "" do
			graphic = Graphic.new @nodes, @edges
		end
	end

	describe "#json_edges" do

		it "" do
			graphic = Graphic.new @nodes, @edges
		end
	end

	describe "#get_json" do

		it "" do
			graphic = Graphic.new @nodes, @edges
			puts graphic.get_json
		end
	end

end
