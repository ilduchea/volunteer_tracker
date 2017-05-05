require 'sinatra'
require 'sinatra/reloader'
require './lib/project'
require './lib/volunteer'
also_reload 'lib/**/*.rb'
require 'pg'

DB = PG.connect({:dbname => "volunteer_tracker"})

get('/') do
	@projects = Project.all('')
	@volunteers = Volunteer.all('')
  erb(:index)
end

get('/new_project') do
	erb(:new_project)
end

post('/add_project') do
	name = params.fetch('name')
	project = Project.new({:name => name})
	project.save
	redirect('/')
end

get('/new_volunteer') do
	erb(:new_volunteer)
end

post('/add_volunteer') do
	name = params.fetch('name')
	volunteer = Volunteer.new({:name => name})
	volunteer.save
	redirect('/')
end

get('/project/:id') do
	project_id = params.fetch('id').to_i
	@project = Project.all("WHERE id = #{project_id}").first
	@volunteers = Volunteer.all("WHERE project_id = #{project_id}")
	@hours = 
	erb(:project)
end

get('/volunteer/:id') do
	erb(:volunteer)
end