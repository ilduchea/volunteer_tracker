class Project
	attr_accessor :name, :id

	def initialize (attributes)
		@name = attributes.fetch(:name)
		@id = attributes[:id]
	end

	def self.all (condition)
		results = DB.exec("SELECT * FROM projects #{condition};")
		Project.to_object(results)
	end

	def save
		result = DB.exec("INSERT INTO projects (name) VALUES ('#{@name}') RETURNING id;")
		@id = result.first['id'].to_i
	end

	def == (another_project)
		name.==(another_project.name).&id.==(another_project.id)
	end

	def self.find_by_volunteer (condition)
		results = DB.exec("SELECT project_id FROM volunteers WHERE #{condition}")
		Project.to_object(results)
  end

  def self.to_object (results)
  	projects = []
		results.each do |project|
			name = project.fetch('name')
			id = project.fetch('id').to_i
			projects.push(Project.new({:name => name, :id => id}))
		end
		projects
  end

  def delete
  	DB.exec("DELETE FROM projects WHERE id = #{self.id};")
  	DB.exec("UPDATE volunteers SET project_id = null WHERE project_id = #{self.id};")
  end

  def update (values_array)
  	values_array.each do |value|
  		DB.exec("UPDATE projects SET #{value} WHERE id = #{self.id};")
  	end
  end
end