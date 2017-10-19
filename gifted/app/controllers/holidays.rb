get '/holidays' do
  Holiday.all.to_json
end

post '/holidays' do
  holiday_attrs = JSON.parse(request.body.read)
  holiday = Holiday.new(holiday_attrs)

  if holiday.save
    # A 201 HTTP response code indicates successful creation of a resource
    [201, holiday.to_json]
  else
    # A 409 HTTP response code indicates conflict
    [409, holiday.errors.to_json]
  end
end
