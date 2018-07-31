class StaticPagesController < ApplicationController
  def home
    @bestsellingitems = Item.all
    @recentview = []
    if current_user!=nil
      Recentlyviewed.where(user_id: current_user.id)
      #current_user.update_attribute :adminrole, true
    end
  end

  def about
  end

  def contact
    #session[:cart] = nil #empties cart/ clears session to stop an error

  end

  def delivery
  end
  


end
