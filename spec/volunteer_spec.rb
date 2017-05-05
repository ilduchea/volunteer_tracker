require 'spec_helper'

describe(Volunteer) do
	describe('#initialize') do
		it('will create a new volunteer') do
			volunteer1 = Volunteer.new({:name => 'Test Volunteer'})
			expect(volunteer1.name).to eq ('Test Volunteer')
		end
	end

	describe('.all') do
		it('will return all volunteers in the database, empty at first') do
			expect(Volunteer.all('')).to eq ([])
		end

		it('will sort the volunteers alphabetically by name') do
      volunteer1 = Volunteer.new({:name => 'Test Volunteer'})
      volunteer1.save
      volunteer2 = Volunteer.new({:name => 'Another Volunteer'})
      volunteer2.save
      volunteer3 = Volunteer.new({:name => 'Clean Parks'})
      volunteer3.save
      volunteer4 = Volunteer.new({:name => 'After School Program'})
      volunteer4.save
      expect(Volunteer.all('ORDER BY name')).to(eq([volunteer4, volunteer2, volunteer3, volunteer1]))
    end

    it('will find a volunteer by their id') do
      volunteer1 = Volunteer.new({:name => 'Test Volunteer'})
      volunteer1.save
      volunteer2 = Volunteer.new({:name => 'Another Volunteer'})
      volunteer2.save
      expect(Volunteer.all("WHERE id = #{volunteer1.id}").first).to(eq(volunteer1))
    end
	end

	describe('#save') do
		it('will add a volunteer to the database') do
			volunteer1 = Volunteer.new({:name => 'Test Volunteer'})
			volunteer1.save
			expect(Volunteer.all('')).to eq ([volunteer1])
		end
	end	

	describe('#delete') do
		it('will remove the volunteer from the database') do
			volunteer1 = Volunteer.new({:name => 'Test Volunteer'})
      volunteer1.save
      volunteer2 = Volunteer.new({:name => 'Another Volunteer'})
      volunteer2.save
      volunteer1.delete
      expect(Volunteer.all('')).to eq ([volunteer2])
    end
  end

  describe('#update') do
  	it('will update the name of a volunteer') do
  		volunteer1 = Volunteer.new({:name => 'Test Volunteer'})
      volunteer1.save
      volunteer1.update(["name = 'New Name'"])
      expect(Volunteer.all('').first.name).to eq ('New Name')
    end
  end

  describe('#add_hours') do
    it('will add hours to the volunteer') do
      volunteer1 = Volunteer.new({:name => 'Test Volunteer'})
      volunteer1.save
      expect(volunteer1.add_hours(5)).to eq (5)
    end
  end
end