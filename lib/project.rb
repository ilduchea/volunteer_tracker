class Project
	attr_accessor :name, :id

	def initialize (attributes)
		@name = attributes.fetch(:name)
		@id = attributes[:id]
	end

	def self.all (condition)
		returned_projects = DB.exec("SELECT * FROM projects ORDER BY #{condition}")
		projects = []
		returned_projects.each do |project|
			name = project.fetch('name')
			id = project.fetch('id').to_i
			projects.push(Project.new({:name => name, :id => id}))
		end
		projects
	end

	def save
		result = DB.exec("INSERT INTO projects (name) VALUES ('#{@name}') RETURNING id;")
		@id = result.first['id'].to_i
	end

	def == (another_project)
		name.==(another_project.name).&id.==(another_project.id)
	end

	def self.find (id)
    Project.all('id').each do |project|
      if project.id == id
        return project
      end
    end
  end
end