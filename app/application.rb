require 'pry'
class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []


  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)
    # line 12 says if the req.path.match(argument)
    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
    elsif req.path.match(/cart/)
      if @@cart.empty?
        resp.write "Your cart is empty"
      else
        @@cart.each do |item|
          # binding.pry
          resp.write "#{item}\n"
        end
      end
    elsif req.path.match(/add/)
      item_to_add = req.params["item"]
      if @@items.include? item_to_add 
        @@cart << item_to_add
        resp.write "added #{item_to_add}"
      else
        resp.write "We don't have that item!"
      end

    end
    resp.finish
  end

  def handle_search(search_term)
    # binding.pry
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end

  # def add(env)
  #   req.path.match(/add/)
  #   item_to_add = req.params["item"]
  #   if @@items.include? item_to_add 
  #     @@cart << item_to_add
  #     resp.write "added #{item_to_add}"
  #   else
  #     resp.write "We don't have that item!"
  #   end

  # end    

  # end
  
end
