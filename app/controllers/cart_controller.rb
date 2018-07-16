class CartController < ApplicationController
 

#method to add item to a cart and create a cart if needed
 def add
   #get product id
   id = params[:id]
   
   #is there a cart already
   if session[:cart] then
     cart = session[:cart]
   else
     session[:cart] = {}
     cart = session[:cart]
   end
   
   #put item in cart
   if cart[id]
     cart[id] = cart[id] + 1
   else
     cart[id] = 1
   end
   
   redirect_to :action => :index
   
 end
 
 
#clear
def clear
   session[:cart] = nil
   redirect_to :action => :index
end

  
 #remove from cart
  def remove
     id = params[:id]
    cart = session[:cart]
    cart.delete id
    redirect_to :action => :index

  end
  



 
 
  #method to display cart 
  def index
    if session[:cart] then
      @cart = session[:cart]
    else
      @cart = {}
    end
  end
 
  
end
