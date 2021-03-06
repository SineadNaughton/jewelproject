class CartController < ApplicationController
 before_action :authenticate_user!


#method to add item to the cart from teh item index page - always adds 1
 def add
  @removewishlistitem
   @hi
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
 
 #add a wishlist item to the cart, it calls the method above and also removes the item fromt eh wishlsit
 def add_from_wishlist
  id = params[:id]
  @removewishlistitem = Wishlistitem.where(user_id: current_user.id, item_id: id)
  @removewishlistitem[0].destroy
  @hi="hiiii"
  add
 end
 
#method to add item to a cart from the show item page - qty must be specified
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
   item = Item.find(params[:id])
   qty_instock = item.quantity_instock
   
   if qty_instock >= qty
   
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
 
 #method to change the quantity of a particular item in the cart
 def update_quantity
     id = params[:id]
     cart = session[:cart]
     qty = "#{params[:qty]}".to_i
     
     @item = Item.find(params[:id])
     @qty_instock = @item.quantity_instock
     
     if @qty_instock < qty
        cart[id] = cart[id]
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
   @recentview = Recentlyviewed.where(user_id: current_user.id)
    if session[:cart] then
      @cart = session[:cart]
    else
      @cart = {}
    end
  end
  
  #method to display cart summary info in header - renders _total partial
   def cart_header_info
    if session[:cart] then
      @cart = session[:cart]
    else
      @cart = {}
    end
   end
   
   def create_order
       #get user, build order, save order
       @user = User.find(current_user.id)
        ordertotal = cart_total
       @order = @user.orders.build(:order_date => DateTime.now, :status => "Pending", :order_total => ordertotal)
       @order.save
       #get cart (it's either session or empty),loop through, get items from item table, and make cart item an orderitem
       @cart = session[:cart] || {}
       @cart.each do | id, quantity |
           item = Item.find_by_id(id)
           #update stock
           quantity_instock = item.quantity_instock
           quantity_sold = item.quantity_sold
           item.update_attribute(:quantity_instock, quantity_instock - quantity)
           item.update_attribute(:quantity_sold, quantity_sold + quantity)
           #create order tiems
           @orderitem = @order.orderitems.build(:item_id => item.id, :title => item.title, :description => item.description, :quantity => quantity, :price => item.price)
           @orderitem.save
           
       end
       @orders = Order.all
       @orderitems = Orderitem.where(order_id: Order.last)
       #clear cart once order created
       session[:cart] = nil
   end
 
   
   def cart_total
       ordertotal = 0
       if session[:cart]
        @cart = session[:cart]
        @cart.each do |id, quantity|
            item = Item.find_by_id(id)
            ordertotal += item.price * quantity
        end
        ordertotal = ordertotal + 5.95
       end
       
           
   end
   




   
  
  
 
  
end
