class UseraccountController < ApplicationController
 before_action :authenticate_user!
 before_action :admin_user, only: [:admin_welcome, :admin_users, :upgrade_admin, :downgrade_admin, :remove, :all_reviews]
 before_action :set_user, only: [:upgrade_admin, :downgrade_admin, :remove]
     
    def welcome
        @recentview = Recentlyviewed.where(user_id: current_user.id)
    end
    
    def userorders
        @orders = Order.where(user_id: current_user.id)
    end
    
    def ordershow
        @order = Order.find(params[:id])
        if current_user.id != @order.user_id
            flash.now[:notice] = "Access Denied"
             redirect_to root_path
        end
        @orderitems = Orderitem.where(order_id: params[:id])
    end
    
    def user_reviews
        @reviews = Review.where(user_id: current_user.id)
    end
    
    def admin_welcome
        @items = Item.all
    end
    
    def admin_users
        @users = User.all
    end
    
    def upgrade_admin
        @user.update_attribute(:adminrole, true)
        redirect_to :action => :admin_users
    end
    
    def downgrade_admin
       @user.update_attribute(:adminrole, false)
       flash.now[:success] = "Admin premission removed"
       redirect_to :action => :admin_users
    end    
    
    def remove
        @user.destroy
        respond_to do |format|
          format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
          format.json { head :no_content }
        end
     
    end  
    
    def all_reviews
        @reviews = Review.all
    end
    
    def manage_stock
        @items = Item.all
    end
    
private
 #this method checks it the current user is admin - it is called before allowing access to certain areas/methods
    def admin_user
      if user_signed_in? && current_user.adminrole?
        flash.now[:success] = "Admin Access Granted"
      else
       redirect_to root_path
      end
    end
 
    def set_user
        @user = User.find(params[:id])
    end
    
    
end
