class UseraccountController < ApplicationController
 before_action :authenticate_user!
     
    def welcome

    end
    
    def userorders
        @orders = Order.where(user_id: current_user.id)
    end
    
    def ordershow
        @orderitems = Orderitem.where(order_id: params[:id])
    end
    
    
end
