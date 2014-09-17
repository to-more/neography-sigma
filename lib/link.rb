require 'neography'

class Link

	attr_reader :link

	def initialize source, target
		@source = source
		@target = target
	end

	def create_link
		Neography::Relationship.create(:link, @source, @target)
		@link = { "id" => self.hash, "source" => @source["id"], "target" => @target["id"] }
	end

end