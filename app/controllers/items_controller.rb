class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :admin_user, only: [:edit, :update, :destroy, :create, :new]
  # GET /items
  # GET /items.json
  
  def index
    #make bestselling items availalbe
    @bestsellingitems = Item.all
    #make bestselling items availalbe
    @recentview = []
    if current_user != nil
      @recentview = Recentlyviewed.where(user_id: current_user.id)  
    end
    
    #make items availalbe based on nav selection
    @items =  []
    @action = params[:kind]
    
    if @action=="newin" then
      since = Date.today-30
      @items = Item.where("created_at > ?", since)
    else 
      @items = Item.where("category like ? OR collection like ?", @action, @action)
    end
    #call sort method
    sortitems 
  end

  # GET /items/1
  # GET /items/1.json
  def show
    #show reviews
    @reviews=Review.where(item_id: @item.id)
    if @item.reviews.blank?
      @average_review = 0
    else
      @average_review = @item.reviews.average(:rating).round(2)
    end
    
    #add a recently viewed item if user logged in
    if current_user != nil
      @user = User.find(current_user.id)
      if Recentlyviewed.where(user_id: current_user.id, item_id: @item.id).count==0
        @viewed = @item.recentlyvieweds.build(:user_id => current_user.id)
        @viewed.save
      end
    end
  end

  # GET /items/new
  def new
    @item = Item.new
  end

  # GET /items/1/edit
  def edit
  end

  # POST /items
  # POST /items.json
  def create
    @item = Item.new(item_params)

    respond_to do |format|
      if @item.save
        format.html { redirect_to @item, notice: 'Item was successfully created.' }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end
  
  #uses input from a form text field to create a cariable that is a seach wildcard.  This is used to query the title and description attributes.
  #query resutls are stored in @items
  def search
    input = "%#{params[:input]}%"
    @items = Item.where("title like ? OR description like ?", input, input)
  end
  
  
  #filters items in index
  def filter
    #if there is no search parameter just use an empty wildcard, else use the search param wildcard
    if params[:input]==nil
      searchinput = '%'
    else
      searchinput = "%#{params[:input]}%"
    end
    #a series of conditional statemetns to check what attributes to query for
    #if nothing in an attribute section is ticked then equal all of them to an empty wildcard so everything is returned
    #else use a turnery operator to check if th variable will have the value of an item string or 'xxxxxxxx'(which will always return nothing) 
    #this is based on whether or not the query param has the value of "✓" 
    if params[:necklace] != "✓"  && params[:bracelet] != "✓"  && params[:ring] != "✓" && params[:earring] != "✓" 
      necklace = '%'
      bracelet = '%'
      ring = '%'
      earring = '%'
    else 
      necklace = params[:necklace] == "✓" ? 'necklace' : 'xxxxxxxx' 
      bracelet = params[:bracelet] == "✓"  ? 'bracelet' : 'xxxxxxxx' 
      ring = params[:ring] == "✓"  ? 'ring' : 'xxxxxxxx' 
      earring = params[:earring] == "✓"  ? 'earring' : 'xxxxxxxx' 
    end
    if params[:gold] != "✓"  && params[:silver] != "✓" && params[:rose] != "✓"
      gold = '%'
      silver = '%'
      rose = '%'
    else 
      gold = params[:gold] == "✓"  ? 'gold' : 'xxxxxxxx' 
      silver = params[:silver] == "✓"  ? 'silver' : 'xxxxxxxx'
      rose = params[:rose] == "✓"  ? 'rose' : 'xxxxxxxx'
    end
    if params[:bohemian] != "✓" && params[:roman] != "✓" && params[:gemstone] != "✓" 
      bohemian = '%'
      roman = '%'
      gemstone = '%'
    else 
      bohemian = params[:bohemian] == "✓"  ? 'bohemian' : 'xxxxxxxx' 
      roman = params[:roman] == "✓"  ? 'roman' : 'xxxxxxxx'
      gemstone = params[:gemstone] == "✓"  ? 'gemstone' : 'xxxxxxxx'
    end
    
    #finally use the variable dertermined above to get the query results - stored in @items
     @items= Item.where("title like ? OR description like ?", searchinput, searchinput)
     @items = @items.where("category like ? OR category like ? OR category like ? OR category like ? ", necklace, bracelet, earring, ring)
     @items = @items.where("material like ? OR material like ? OR material like ?", gold, silver, rose)
     @items = @items.where("collection like ? OR collection like ? OR collection like ?", bohemian, roman, gemstone)
    
    #call sort method - default price asc
     sortitems
     
     #give access to bestselling and recently viewed tables
     @bestsellingitems = Item.all
     @recentview = []
     if current_user != nil
      @recentview = Recentlyviewed.where(user_id: current_user.id)  
     end
  end
  



  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item.destroy
    respond_to do |format|
      format.html { redirect_to items_url, notice: 'Item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
     
     @item = Item.find(params[:id]) rescue nil
     if @item == nil
       redirect_to :action => :index
     end
     

    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:title, :description, :price, :image_url, :category, :material, :collection, :quantity_instock, :quantity_sold, :image)
    end
    
    #this method checks it the current user is admin - it is called before allowing access to certain areas/methods
    def admin_user
      if user_signed_in? && current_user.adminrole?
        flash.now[:success] = "Admin Access Granted"
      else
        redirect_to root_path
      end
    end
    
    def sortitems
        sort = params[:sort]
      if sort == 'price-asc'
          @items = @items.order("price asc")
      elsif sort == 'price-desc'
        @items = @items.order("price desc")
      elsif sort == 'newin'
        @items = @items.order("created_at asc")
      end
    end
   
end
