class Project
	attr_accessor :name, :id

	def initialize (attributes)
		@name = attributes.fetch(:name)
		@id = attributes[:id]
	end
end