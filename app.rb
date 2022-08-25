require 'sinatra'
require 'make_todo'
# require 'sinatra/reloader' if development?

# tasks = Tarea.all
tasks = []

get '/' do
	@tasks = tasks

	erb :index
end

get '/new-task' do
	erb :add_task
end

post '/add-task' do
	new_task = {}
	new_task[:id] = Time.now.to_i
	new_task[:name] = params[:name]
	params[:status].eql?('true') ? new_task[:status] = true : new_task[:status] = false
	tasks << new_task

	redirect '/'
end

# put

post '/update-task/' do
	id = params[:id].to_i

	tasks.each do |task|
		if task[:id].eql?(id)
			puts task
			task[:status] = true unless task[:status]
		end
	end

	redirect '/'
end

# delete

post '/delete-task/' do
	id = params[:id].to_i

	tasks.each do |task|
		if task[:id].eql?(id)
			index = tasks.index(task)
			tasks.delete_at(index)
		end
	end

	redirect '/'
end
