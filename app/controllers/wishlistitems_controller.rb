class WishlistitemsController < ApplicationController
  before_action :set_wishlist_item, only: [:destroy]
   before_action :authenticate_user!
  
  def add
      id = params[:id]
       #get user, build order, save order
       @user = User.find(current_user.id)
       @item = Item.find_by_id(id)
       if Wishlistitem.where(user_id: current_user.id, item_id: id).count==0
        @wishlistitem = @item.wishlistitems.build(:user_id => current_user.id)
        @wishlistitem.save
       end
       
       redirect_to :action => :index
  end

  def remove
  end

  def index
    @wishlistitems = Wishlistitem.where(user_id: current_user.id)
  end
  
  def destroy
    @wishlistitem.destroy
    respond_to do |format|
      format.html { redirect_to wishlistitems_url, notice: 'Wishlist item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  
    private
    # Use callbacks to share common setup or constraints between actions.
    def set_wishlist_item
      @wishlistitem = Wishlistitem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def wishlist_item_params
      params.require(:wishlistitem).permit(:id, :user_id, :item_id)
    end
end
