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
			expect(Project.all('id')).to eq ([])
		end
	end

	describe('#save') do
		it('will add a project to the database') do
			project1 = Project.new({:name => 'Test Project'})
			project1.save
			expect(Project.all('id')).to eq ([project1])
		end
	end

	describe('.find') do
    it('will find a project by their id') do
      project1 = Project.new({:name => 'Test Project'})
      project1.save
      project2 = Project.new({:name => 'Another Project'})
      project2.save
      expect(Project.find(project1.id)).to(eq(project1))
    end
  end

  describe('.all') do
    it('will sort the projects alphabetically by name') do
      project1 = Project.new({:name => 'Test Project'})
      project1.save
      project2 = Project.new({:name => 'Another Project'})
      project2.save
      project3 = Project.new({:name => 'Clean Parks'})
      project3.save
      project4 = Project.new({:name => 'After School Program'})
      project4.save
      expect(Project.all('name')).to(eq([project4, project2, project3, project1]))
    end
  end
end