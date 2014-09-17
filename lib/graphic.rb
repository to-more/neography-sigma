require 'json'
require 'builder'

class Graphic

	def initialize nodes = nil, edges = nil
		@nodes = nodes
		@edges = edges
	end

	def create_gexf

  		xml = Builder::XmlMarkup.new

		xml.instruct! :xml
		
		xml.gexf 'xmlns' => "http://www.gephi.org/gexf", 'xmlns:viz' => "http://www.gephi.org/gexf/viz"  do
		  xml.graph 'defaultedgetype' => "directed", 'idtype' => "string", 'type' => "static" do
		  	if @nodes
			    xml.nodes :count => @nodes.size do
			      @nodes.each do |n|
			        xml.node :id => n["id"], :label => n["name"] do
					   xml.tag!("viz:size", :value => n["size"])
					   xml.tag!("viz:color", :b => n["b"], :g => n["g"], :r => n["r"])
					   xml.tag!("viz:position", :x => n["x"], :y => n["y"]) 
				 	end
			      end
			    end
			end

			if @edges
			    xml.edges :count => @edges.size do
			      @edges.each do |e|
			        xml.edge:id => e["id"], :source => e["source"], :target => e["target"] 
			      end
			    end
			end
		  end
		end
		
		File.open("public/graph.xml", 'w') { |file| file.write(xml.target!) }
	end


	def get_json
		"{ nodes : #{json_nodes}, edges : #{json_edges} }"
	end  

	def json_nodes
		
		nodes = Array.new
		@nodes.each do | n | 

			node = { 
				"name" => n["name"],
				"size" => n["size"],
				"r" => n["r"],
				"g" => n["g"],
				"b" => n["b"],
				"x" => n["x"],
				"y" => n["y"] 
			}
			nodes << node.to_json
		end

		nodes.to_json		
	end

	def json_edges
		
		edges = Array.new

		@edges.each do | e | 
			edge = { 
				"id" => e["id"],
				"source" => e["source"],
				"target" => e["target"]
			}
			edges << edge.to_json
		end
		
		edges.to_json	
	end
end