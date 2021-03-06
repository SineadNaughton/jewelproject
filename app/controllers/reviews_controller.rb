class ReviewsController < ApplicationController
  before_action :authenticate_user!
 
  before_action :set_review, only: [:show, :edit, :update, :destroy]
  before_action :find_item
  before_action :admin_user, only: [:destroy]
  

  # GET /reviews
  # GET /reviews.json
  def index
    @reviews = Review.all
  end

  # GET /reviews/1
  # GET /reviews/1.json
  def show
  end

  # GET /reviews/new
  def new
    @review = Review.new
  end
  



  # POST /reviews
  # POST /reviews.json
  def create
    @review = Review.new(review_params)
    #set item id of @review to current item id
    @review.item_id = @item.id
    @review.user_id = current_user.id
   

    respond_to do |format|
      if @review.save
        format.html { redirect_to @item, notice: 'Review was successfully created.' }
        format.json { render :show, status: :created, location: @review }
      else
        format.html { render :new }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
    

  end
  
  
  # GET /reviews/1/edit
  def edit
  end

  # PATCH/PUT /reviews/1
  # PATCH/PUT /reviews/1.json
  def update
    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to item_path(@item), notice: 'Review was successfully updated.' }
        format.json { render :show, status: :ok, location: @review }
      else
        format.html { render :edit }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1
  # DELETE /reviews/1.json
  def destroy
    @review.destroy
    respond_to do |format|
      format.html { redirect_to item_path(@item), notice: 'Review was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_review
      @review = Review.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def review_params
      params.require(:review).permit(:item_id, :user_id, :title, :description, :rating, :orderitem_id)
    end
    
    def find_item
      @item = Item.find(params[:item_id])
    end
    
    def check_edit_rights
      if review.user_id == current_user.id
        flash.now[:success] = "Edit Access Granted"
      else
        redirect_to root_path
      end
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
    

    

