class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy] 
  before_action :ensure_admin, only: [:add, :edit, :destroy]
 
  # GET /products
  # GET /products.json

   def ensure_admin
    unless current_user && current_user.admin?
      render :text => "Unauthorised Access", :status => :unauthorized
    end 
  end

  def index    
      if params[:search]
        @products = Product.search(params[:search]).order("title ASC").paginate(page: params[:page], per_page: 6)   
      elsif params[:category]
        @category_id = Category.find_by(name: params[:category]).id
        @products = Product.where(:category_id => @category_id).order("title ASC").paginate(page: params[:page], per_page: 6) 
      else
        @products = Product.all.order("title ASC").paginate(page: params[:page], per_page: 6) 
      end 

  end

  # GET /products/1
  # GET /products/1.json
  def show
    if @product.reviews.blank?
      @average_review = 0
    else
      @average_review = @product.reviews.average(:rating).round(2)
    end
  end

  # GET /products/new
  def new
    @product = current_user.products.build
    @categories = Category.all.map{ |c| [c.name, c.id]}
  end

  # GET /products/1/edit
  def edit
    @categories = Category.all.map{ |c| [c.name, c.id] }
  end

  # POST /products
  # POST /products.json
  def create
    @product = current_user.products.build(product_params)
    @product.category_id = params[:category_id]

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    @categories = Category.all.map{ |c| [c.name, c.id] }
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:title, :price, :desc, :image_url, :category_id)
    end
end
