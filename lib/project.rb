require 'descriptive_statistics'

class Project
	attr_accessor :name, :id

	def initialize (attributes)
		@name = attributes.fetch(:name)
		@id = attributes[:id]
	end

	def self.all ()
		results = DB.exec("SELECT * FROM projects;")
		Project.to_object(results)
	end

	def self.where (array)
		results = DB.exec("SELECT * FROM projects WHERE #{array[0]} = #{array[1]};")
		Project.to_object(results)
	end

	def self.sort_by(key)
		results = DB.exec("SELECT * FROM projects ORDER BY #{key};")
		Project.to_object(results)
	end

	def hours
		hours_array = []
		if @hours.class == nil
			hours_array = [0]
		else
			results = DB.exec("SELECT * FROM volunteers WHERE project_id = #{@id};")
			results.each do |result|
				hours = result.fetch('hours').to_i
				hours_array.push(hours)
			end
		end
		hours_array.sum
	end

	def save
		result = DB.exec("INSERT INTO projects (name) VALUES ('#{@name}') RETURNING id;")
		@id = result.first['id'].to_i
	end

	def == (another_project)
		if another_project == nil
			return false
		else
			name.==(another_project.name).&id.==(another_project.id)
		end
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

	def update (array)
  	DB.exec("UPDATE projects SET #{array[0]} = #{array[1]} WHERE id = #{self.id};")
  end
end
