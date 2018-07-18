class CartController < ApplicationController
 before_action :authenticate_user!


#method to add item to the cart from teh item index page - always adds 1
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
 
#method to add item to a cart from teh show item page - qty must be specified
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
 #method to change teh quantity of a particular item in the cart
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
       @order = @user.orders.build(:order_date => DateTime.now, :status => "Pending")
       @order.save
       #get cart (it's either session or empty),loop through, get items from item table, and make cart item an orderitem
       @cart = session[:cart] || {}
       @cart.each do | id, quantity |
           item = Item.find_by_id(id)
           @orderitem = @order.orderitems.build(:item_id => item.id, :title => item.title, :description => item.description, :quantity => quantity, :price => item.price)
           @orderitem.save
       end
       @orders = Order.all
       @orderitems = Orderitem.where(order_id: Order.last)
       

       

   end
  
  
 
  
end
