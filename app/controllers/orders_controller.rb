class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy, :shipped]
  before_action :admin_user, only: [:index, :show, :edit, :update, :destroy, :create, :new, :shipped]

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all
    
  end

  def user_orders
   # @orders = Order.where(user_id: current_user.id)
  end
  
  # GET /orders/1
  # GET /orders/1.json
  def show
    
    @orderitems = Orderitem.where(order_id: params[:id])
 
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end
  
  def pay
    #instance var called @order and equal it to the last order in the Order table can also filter by param as above
    @bestsellingitems = Item.all
    @order = Order.last
    #update the attribute
    @order.update_attribute(:status, "Paid by User: #{current_user.username}")
    @orderitems = Orderitem.where(order_id: @order.id)
  end
  

  def shipped
        #instance variable to give it teh value of current order id
    #Order.where(order_id: params[:id]).update_all(:status "Dispatched") remove this code
    #update the attribute remove this code
    
    @order.update_attribute(:status, "Dispatched")
    redirect_to :action => :index
    
    
    #User.where(name: "Robbie").update_all(name: "Rob")
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)

    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:order_date, :user_id, :status, :order_total, :action)
    end
    
    #this method checks it the current user is admin - it is called before allowing access to certain areas/methods
    def admin_user
      if user_signed_in? && current_user.adminrole?
     
      flash.now[:success] = "Admin Access Granted"
     else
      redirect_to root_path
     end
    end
    
end
