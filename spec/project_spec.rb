require 'spec_helper'

describe(Project) do
	describe('#initialize') do
		it('will create a new project') do
			project_test = Project.new({:name => 'Test Project'})
			expect(project_test.name).to eq ('Test Project')
		end
	end

	describe('.all') do
		it('will return all projects in the database, empty at first') do
			expect(Project.all).to eq ([])
		end
	end

	describe('#save') do
		it('will add a project to the database') do
			project_test = Project.new({:name => 'Test Project'})
			project_test.save
			expect(Project.all).to eq ([project_test])
		end
	end
end