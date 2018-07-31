class UseraccountController < ApplicationController
 before_action :authenticate_user!
 before_action :admin_user, only: [:admin_welcome, :admin_users
 ]
     
    def welcome
        @recentview = Recentlyviewed.where(user_id: current_user.id)
    end
    
    def userorders
        @orders = Order.where(user_id: current_user.id)
    end
    
    def ordershow
        @orderitems = Orderitem.where(order_id: params[:id])
    end
    
    def user_reviews
        @reviews = Review.where(user_id: current_user.id)
    end
    
    def admin_welcome
        
    end
    
    def admin_users
        @users = User.all
    end
    
private
 def admin_user
  if current_user.adminrole?
   flash.now[:success] = "Admin Access Granted"
  else
   redirect_to root_path
  end
 end
    
    
end
