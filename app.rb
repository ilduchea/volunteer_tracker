require 'sinatra'
require 'sinatra/reloader'
require './lib/project'
require './lib/volunteer'
also_reload 'lib/**/*.rb'
require 'pg'

DB = PG.connect({:dbname => "volunteer_tracker"})

get('/') do
	@projects = Project.all()
	@volunteers = Volunteer.all()
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
	volunteer.add_hours(0)
	volunteer.save
	redirect('/')
end

get('/project/:id') do
	project_id = params.fetch('id').to_i
	@project = Project.where(['id', project_id]).first
	@volunteers = Volunteer.where(['project_id', project_id])
	@hours = @project.hours
	erb(:project)
end

post('/update_project/:id') do
	project_id = params.fetch('id').to_i
	name = params.fetch('name')
	@project = Project.where(['id', project_id]).first
	@project.update(['name', "'#{name}'"])
	redirect("/project/#{project_id}")
end

post('/delete_project/:id') do
	project_id = params.fetch('id').to_i
	@project = Project.where(['id', project_id]).first
	@project.delete
	redirect('/')
end

get('/volunteer/:id') do
	volunteer_id = params.fetch('id').to_i
	@volunteer = Volunteer.where(['id', volunteer_id]).first
	@projects = Project.all()
	@project = Project.where(['id', @volunteer.project_id]).first
	erb(:volunteer)
end

post('/update_name/:id') do
	volunteer_id = params.fetch('id').to_i
	name = params.fetch('name')
	@volunteer = Volunteer.where(['id', volunteer_id]).first
	@volunteer.update(['name', "'#{name}'"])
	redirect("/volunteer/#{volunteer_id}")
end

post('/update_volunteer_project/:id') do
	volunteer_id = params.fetch('id').to_i
	project_id = params.fetch('project').to_i
	@volunteer = Volunteer.where(['id', volunteer_id]).first
	@volunteer.update(['project_id', project_id])
	redirect("/volunteer/#{volunteer_id}")
end

post('/update_hours/:id') do
	volunteer_id = params.fetch('id').to_i
	hours = params.fetch('hours').to_i
	@volunteer = Volunteer.where(['id', volunteer_id]).first
	@volunteer.add_hours(hours)
	@volunteer.update(['hours', @volunteer.hours])
	redirect("/volunteer/#{volunteer_id}")
end

post('/delete_volunteer/:id') do
	volunteer_id = params.fetch('id').to_i
	@volunteer = Volunteer.where(['id', volunteer_id]).first
	@volunteer.delete
	redirect('/')
end
