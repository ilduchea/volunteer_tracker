class Project
	attr_accessor :name, :id

	def initialize (attributes)
		@name = attributes.fetch(:name)
		@id = attributes[:id]
	end

	def self.all 
		returned_projects = DB.exec("SELECT * FROM projects")
		projects = []
		returned_projects.each do |project|
			name = data.fetch('name')
			id = data.fetch('id')
			projects.push(Project.new({:name => name, :id => id}))
		end
		projects
	end
end