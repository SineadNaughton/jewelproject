class StaticPagesController < ApplicationController
  def home
    @bestsellingitems = Item.all
      #current_user.update_attribute :adminrole, true
   
  end

  def about
  end

  def contact
    session[:cart] = nil #empties cart/ clears session to stop an error

  end

  def delivery
  end
  


end
