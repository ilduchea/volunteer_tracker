require 'spec_helper'

describe(Volunteer) do
	describe('#initialize') do
		it('will create a new project') do
			volunteer_test = Volunteer.new({:name => 'Joe'})
			expect(volunteer_test.name).to eq ('Joe')
		end
	end
end