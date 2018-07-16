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
 
#method to add item to a cart and create a cart if needed
 def add_by_quantity
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
   qty = "#{params[:qty]}".to_i
   @item = Item.find(params[:id])
   @qty_instock = @item.quantity_instock
   
   if @qty_instock >= qty
   
        if cart[id]
             cart[id] = cart[id] + qty
         else
             cart[id] = qty
        end
        redirect_to :action => :index
    else
        redirect_to @item, notice: 'There are not enough items in stock!'
        
        
   end
 end
 
 def update_quantity
     id = params[:id]
     cart = session[:cart]
     qty = "#{params[:qty]}".to_i
     
     @item = Item.find(params[:id])
     @qty_instock = @item.quantity_instock
     
     if @qty_instock < qty
        cart[id] = 1
        flash[:error] = "There are not enough items in stock!"
     else
        cart[id] = qty
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
