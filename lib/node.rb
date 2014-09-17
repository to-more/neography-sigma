require 'neography'

class Node

	attr_reader :properties	

	def initialize init_hash = nil
		@default_properties = init_hash
		@properties = { :size => 1 }
	end

	def create node
		
		class_name = node.class.name
		id = node.hash

		neo_node = Neography::Node.create ( { "id" => id, "class" => class_name } )
		
		set_default_properties_to neo_node

		@properties[ :id ] = id
		@properties[ :class ] = class_name
		
		node.instance_variables.each do | node_attr |

			node_attr_s = clean_name_of node_attr

			node_attr_sym = node_attr_s.to_sym
			value = node.instance_variable_get node_attr
			neo_node[ node_attr_sym ] = value
			@properties[ node_attr_sym ] = value
		end
		
		index = { :index => "node_index", :key => "id", :value => id }

		properties[:index] = index
		neo_node["size"] = properties[:size]
		
		neo_node.add_to_index( index[:index], index[:key], index[:value])
	end

	def retrieve
		get_node
	end

	def destroy

		node = get_node

		node.del
	end

	def change size
		node = get_node
		node[size] = size
		@properties[:size] = size
	end

	private

	def get_node
	
		@neo = Neography::Rest.new
		
		index = properties[:index]

		node_index = @neo.get_node_index(
			index[:index],
			index[:key], 
			index[:value]
		)
		index = nil

		index = node_index[0] if node_index

		neo_index = nil
		
		neo_index = Neography::Node.load(index["indexed"], @neo) if index

		neo_index
	end

	def clean_name_of instance_variable
		node_attr_s = instance_variable.to_s.gsub '@', '' if instance_variable.to_s.include? '@'
	end

	def set_default_properties_to neo_node
		if @default_properties
			@default_properties.each do | key, value |
				neo_node[ key ] = value
			end
		end
	end
end