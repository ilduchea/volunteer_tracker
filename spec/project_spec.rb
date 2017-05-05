require 'spec_helper'

describe(Project) do
	describe('#initialize') do
		it('will create a new project') do
			project1 = Project.new({:name => 'Test Project'})
			expect(project1.name).to eq ('Test Project')
		end
	end

	describe('.all') do
		it('will return all projects in the database, empty at first') do
			expect(Project.all('')).to eq ([])
		end

		it('will sort the projects alphabetically by name') do
      project1 = Project.new({:name => 'Test Project'})
      project1.save
      project2 = Project.new({:name => 'Another Project'})
      project2.save
      project3 = Project.new({:name => 'Clean Parks'})
      project3.save
      project4 = Project.new({:name => 'After School Program'})
      project4.save
      expect(Project.all('ORDER BY name')).to(eq([project4, project2, project3, project1]))
    end

    it('will find a project by their id') do
      project1 = Project.new({:name => 'Test Project'})
      project1.save
      project2 = Project.new({:name => 'Another Project'})
      project2.save
      expect(Project.all("WHERE id = #{project1.id}").first).to(eq(project1))
    end
	end

	describe('#save') do
		it('will add a project to the database') do
			project1 = Project.new({:name => 'Test Project'})
			project1.save
			expect(Project.all('')).to eq ([project1])
		end
	end	

	describe('#delete') do
		it('will remove the project from the database') do
			project1 = Project.new({:name => 'Test Project'})
      project1.save
      project2 = Project.new({:name => 'Another Project'})
      project2.save
      project1.delete
      expect(Project.all('')).to eq ([project2])
    end
  end

  describe('#update') do
  	it('will update the name of a project') do
  		project1 = Project.new({:name => 'Test Project'})
      project1.save
      project1.update(["name = 'New Name'"])
      expect(Project.all('').first.name).to eq ('New Name')
    end
  end
end