require 'sinatra'
require 'make_todo'
# require 'sinatra/reloader' if development?

# tasks = Tarea.all
tasks = []
complete_tasks = []
incomplete_tasks = []

get '/' do
	@tasks = tasks
	@type_tasks = params[:type_tasks]
	@complete_tasks = complete_tasks
	@incomplete_tasks = incomplete_tasks
	
	erb :index
end

get '/new-task' do
	erb :add_task
end

post '/add-task' do
	params[:status].eql?('true') ? params[:status] = true : params[:status] = false
	new_task = {
		id: Time.now.to_i,
		name: params[:name],
		status: params[:status]
	}

	tasks << new_task
	new_task[:status] ? complete_tasks << new_task : incomplete_tasks << new_task

	redirect '/'
end

# put

post '/update-task/' do
	id = params[:id].to_i

	tasks.each do |task|
		if task[:id].eql?(id)
			task[:status] = true unless task[:status]
		end
	end

	incomplete_tasks.each do |task|
		if task[:id].eql?(id)
			index = incomplete_tasks.index(task)
			incomplete_tasks.delete_at(index) if task[:status]
			complete_tasks << task
		end
	end

	redirect '/'
end

# delete

post '/delete-task/' do
	id = params[:id].to_i

	# all tasks array

	tasks.each do |task|
		if task[:id].eql?(id)
			index = tasks.index(task)
			tasks.delete_at(index)
		end
	end

	# incomplete tasks array

	incomplete_tasks.each do |task|
		if task[:id].eql?(id)
			index = incomplete_tasks.index(task)
			incomplete_tasks.delete_at(index)
		end
	end

	# complete tasks array

	complete_tasks.each do |task|
		if task[:id].eql?(id)
			index = complete_tasks.index(task)
			complete_tasks.delete_at(index)
		end
	end

	redirect '/'
end
