require 'faker'

LISTS = {
  friends: [],
  work: [],
  nyc: [],
  tech: [],
  california: [],
  education: []
}

USERS = Array.new(300) { Faker::Internet.user_name }

USERS.each do |user|
  (rand(3) + 1).times do
    LISTS[LISTS.keys.sample] << user
  end
end

require 'sinatra'

ROOT = File.dirname(__FILE__)

set :root, ROOT
set :views, ROOT

get '/' do
  @users = USERS
  erb :index
end

get '/union' do
  set_a = params[:set_a].to_sym
  set_b = params[:set_b].to_sym

  @users = LISTS[set_a] | LISTS[set_b]

  erb :index
end
