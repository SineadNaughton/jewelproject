class StaticPagesController < ApplicationController
  def home
  end

  def about
  end

  def contact
    session[:cart] = nil #empties cart/ clears session to stop an error
  redirect_to destroy_user_session_path, :method => :delete
  end

  def delivery
  end
end
