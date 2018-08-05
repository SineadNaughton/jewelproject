class StaticPagesController < ApplicationController
  
  
  
  
  
  def home
    @bestsellingitems = Item.all
    #this redirect customers who have just logged in to thier welcome page, rather than the devise redirct which is to the home page
    #it will only redirect them the first time they land ont eh home page during their session - which is imediately after logging in
    if current_user != nil && current_user.adminrole == true
      isfirsttime = session[:isfirsttime] 
        if isfirsttime == nil
          session[:isfirsttime] = true
          redirect_to admin_path
        end
    
    elsif current_user != nil && current_user.adminrole == false
      isfirsttime = session[:isfirsttime] 
      if isfirsttime == nil
        session[:isfirsttime] = true
        redirect_to useraccount_welcome_path
      end
    end
  end

  def about
      #current_user.update_attribute :adminrole, true
      #Order.destroy_all
  end

  def contact
    session[:cart] = nil #empties cart/ clears session to stop an error

  end

  def delivery
  end
  


end
