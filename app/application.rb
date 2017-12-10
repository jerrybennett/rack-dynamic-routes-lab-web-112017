class Application

  @@items = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    item_name = req.path.split("/items/").last
    item_price = @@items.find{|i| i.name == item_name}

    if !req.path.match(/items/)
      resp.write "Route not found"
      resp.status = 404
    elsif !item_price
      resp.write "Item not found"
      resp.status = 400
    else
      resp.write item_price.price
    end

    resp.finish
  end
end
