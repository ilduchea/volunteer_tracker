class Volunteer
	attr_accessor :name, :hours, :project_id, :id

	def initialize (attributes)
		@name = attributes.fetch(:name)
		@hours = attributes[:hours]
		@project_id = attributes[:project_id]
		@id = attributes[:id]
	end

	def self.all ()
		results = DB.exec("SELECT * FROM volunteers;")
		Volunteer.to_object(results)
	end

	def self.where (array)
		results = DB.exec("SELECT * FROM volunteers WHERE #{array[0]} = #{array[1]};")
		Volunteer.to_object(results)
	end

	def self.sort_by(key)
		results = DB.exec("SELECT * FROM volunteers ORDER BY #{key};")
		Volunteer.to_object(results)
	end

	def save
		result = DB.exec("INSERT INTO volunteers (name, hours) VALUES ('#{@name}', #{@hours}) RETURNING id;")
		@id = result.first['id'].to_i
	end

	def == (another_volunteer)
		name.==(another_volunteer.name).&id.==(another_volunteer.id)
	end

	def self.find_by_volunteer (condition)
		results = DB.exec("SELECT project_id FROM volunteers WHERE #{condition}")
		Volunteer.to_object(results)
  end

  def self.to_object (results)
  	volunteers = []
		results.each do |volunteer|
			name = volunteer.fetch('name')
			hours = volunteer.fetch('hours')
			project_id = volunteer.fetch('project_id').to_i
			id = volunteer.fetch('id').to_i
			volunteers.push(Volunteer.new({:name => name, :hours => hours, :project_id => project_id, :id => id}))
		end
		volunteers
  end

  def delete
  	DB.exec("DELETE FROM volunteers WHERE id = #{self.id};")
  end

  def update (array)
  	DB.exec("UPDATE volunteers SET #{array[0]} = #{array[1]} WHERE id = #{self.id};")
  end

  def add_hours (hours)
  	new_hours = 0
  	if @hours == nil
  		new_hours = hours
  	else
  		new_hours = @hours.to_i.+(hours)
  	end
  	@hours = new_hours
  end
end
