require 'spec_helper'

describe(Volunteer) do
	describe('#initialize') do
		it('will create a new volunteer') do
			volunteer1 = Volunteer.new({:name => 'Test Volunteer', :hours => 0})
			expect(volunteer1.name).to eq ('Test Volunteer')
		end
	end

	describe('.all') do
		it('will return all volunteers in the database, empty at first') do
			expect(Volunteer.all()).to eq ([])
		end
	end

	describe('.sort_by') do
		it('will sort the volunteers alphabetically by name') do
			volunteer1 = Volunteer.new({:name => 'Test Volunteer', :hours => 0})
			volunteer1.save
			volunteer2 = Volunteer.new({:name => 'Another Volunteer', :hours => 0})
			volunteer2.save
			volunteer3 = Volunteer.new({:name => 'Clean Parks', :hours => 0})
			volunteer3.save
			volunteer4 = Volunteer.new({:name => 'After School Program', :hours => 0})
			volunteer4.save
			expect(Volunteer.sort_by('name')).to(eq([volunteer4, volunteer2, volunteer3, volunteer1]))
		end
	end

	describe('.where') do
		it('will find a volunteer by their id') do
			volunteer1 = Volunteer.new({:name => 'Test Volunteer', :hours => 0})
			volunteer1.save
			volunteer2 = Volunteer.new({:name => 'Another Volunteer', :hours => 0})
			volunteer2.save
			expect(Volunteer.where(['id', volunteer1.id]).first).to(eq(volunteer1))
		end
	end


	describe('#save') do
		it('will add a volunteer to the database') do
			volunteer1 = Volunteer.new({:name => 'Test Volunteer', :hours => 0})
			volunteer1.save
			expect(Volunteer.all()).to eq ([volunteer1])
		end
	end

	describe('#delete') do
		it('will remove the volunteer from the database') do
			volunteer1 = Volunteer.new({:name => 'Test Volunteer', :hours => 0})
      volunteer1.save
      volunteer2 = Volunteer.new({:name => 'Another Volunteer', :hours => 0})
      volunteer2.save
      volunteer1.delete
      expect(Volunteer.all()).to eq ([volunteer2])
    end
  end

  describe('#update') do
  	it('will update the name of a volunteer') do
  		volunteer1 = Volunteer.new({:name => 'Test Volunteer', :hours => 0})
      volunteer1.save
      volunteer1.update(['name', "'New Name'"])
      expect(Volunteer.all().first.name).to eq ('New Name')
    end
  end

  describe('#add_hours') do
    it('will add hours to the volunteer') do
      volunteer1 = Volunteer.new({:name => 'Test Volunteer'})
			volunteer1.add_hours(5)
      volunteer1.save
      expect(volunteer1.hours).to eq (5)
    end
  end
end
