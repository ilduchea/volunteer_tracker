require 'spec_helper'

describe(Project) do
	describe('#initialize') do
		it('will create a new project') do
			project_test = Project.new({:name => 'Test Project'})
			expect(project_test.name).to eq ('Test Project')
		end
	end
end