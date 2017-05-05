require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('adding a new project', {:type => :feature}) do
  it('allows a user to create a new project') do
    visit('/')
    click_link('Create Project')
    fill_in('name', :with =>'New Project')
    click_button('Create Project')
    expect(page).to have_content('New Project')
  end
end

describe('adding a new volunteer', {:type => :feature}) do
  it('allows a user to create a new volunteer') do
    visit('/')
    click_link('Create Volunteer')
    fill_in('name', :with =>'New Volunteer')
    click_button('Create Volunteer')
    expect(page).to have_content('New Volunteer')
  end
end