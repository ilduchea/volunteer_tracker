class Volunteer
	attr_accessor :name, :hours, :project_id, :id

	def initialize (attributes)
		@name = attributes.fetch(:name)
		@hours = attributes[:hours]
		@project_id = attributes[:project_id]
		@id = attributes[:id]
	end

	def self.all (condition)
		results = DB.exec("SELECT * FROM volunteers #{condition};")
		Volunteer.to_object(results)
	end

	def save
		result = DB.exec("INSERT INTO volunteers (name) VALUES ('#{@name}') RETURNING id;")
		@id = result.first['id'].to_i
	end

	def == (another_voluteer)
		name.==(another_voluteer.name).&id.==(another_voluteer.id)
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

  def update (values_array)
  	values_array.each do |value|
  		DB.exec("UPDATE volunteers SET #{value} WHERE id = #{self.id};")
  	end
  end
end