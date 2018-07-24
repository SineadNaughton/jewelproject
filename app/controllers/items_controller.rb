class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  # GET /items
  # GET /items.json
  def index
    action = params[:kind]
    if action=="newin" then
      since = Date.today-1
      @items = Item.where("created_at > ?", since)
    else 
    #if params["action"]
    #end
    #@items = Item.all
    @items = Item.where("category like ? OR collection like ?", action, action)
    end
  end

  # GET /items/1
  # GET /items/1.json
  def show
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
  
  def search
    input = "%#{params[:input]}%"
    @items = Item.where("title like ?", input)
  end
  
  def filter
   # material = 
    #material.each do |type|
      
    material = "'%#{params[:material]}%'"
    collection = "'%#{params[:collection]}%'"
    category = "'%#{params[:category]}%'"
    query = ""
    if material != nil
      query += " material like #{material}"
    end
    if 
      collection != nil
      query +=" AND collection like #{collection}"
    end
    if 
      category != nil
      query +=" AND category like #{category}"
    end
    
    @items = Item.where(query)
      
    
    #@item = Item.where("1=1")
    #@items = Item.where("material like ? OR collection like ? OR category like ?", material, collection, category)
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
      @item = Item.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:title, :description, :price, :image_url, :category, :material, :collection, :quantity_instock, :quantity_sold, :image)
    end
end
