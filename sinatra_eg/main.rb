require 'sinatra'

get '/' do
  @title = "foo"

  @one_through_ten = (1..10).to_a

  @list_of_nums = ""

  10.times do |x|
    @list_of_nums << "<li>#{x}</li>"
  end

  erb :index
end
