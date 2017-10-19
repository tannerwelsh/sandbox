get '/gifts' do
  Gift.all.to_json
end

post '/gifts' do
  gift_attrs = JSON.parse(request.body.read)
  gift = Gift.new(gift_attrs)

  if gift.save
    # A 201 HTTP response code indicates successful creation of a resource
    [201, gift.to_json]
  else
    # A 409 HTTP response code indicates conflict
    [409, gift.errors.to_json]
  end
end
