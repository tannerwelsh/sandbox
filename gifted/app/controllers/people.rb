get '/people' do
  Person.all.to_json
end

post '/people' do
  person_attrs = JSON.parse(request.body.read)
  person = Person.new(person_attrs)

  if person.save
    # A 201 HTTP response code indicates successful creation of a resource
    [201, person.to_json]
  else
    # A 409 HTTP response code indicates conflict
    [409, person.errors.to_json]
  end
end
