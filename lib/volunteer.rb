class Volunteer
	attr_accessor :name, :hours, :project_id, :id

	def initialize (attributes)
		@name = attributes.fetch(:name)
		@hours = attributes[:hours]
		@project_id = attributes[:project_id]
		@id = attributes[:id]
	end
end