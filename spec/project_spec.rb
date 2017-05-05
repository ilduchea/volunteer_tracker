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
			expect(Project.all).to eq ([])
		end
	end

	describe('#save') do
		it('will add a project to the database') do
			project1 = Project.new({:name => 'Test Project'})
			project1.save
			expect(Project.all).to eq ([project1])
		end
	end

	describe('.find') do
    it('will find a project by their id') do
      project1 = Project.new({:name => 'Test Project'})
      project1.save
      project2 = Project.new({:name => 'Battle Axe', :player_name => 'Test2', :game_sys => 'D&D 3.5'})
      project2.save
      expect(Project.find(project1.id)).to(eq(project1))
    end
  end
end