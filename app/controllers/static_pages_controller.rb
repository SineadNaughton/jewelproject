class StaticPagesController < ApplicationController
  def home
  end

  def about
  end

  def contact
    session[:cart] = nil #empties cart/ clears session to stop an error

  end

  def delivery
  end
end
