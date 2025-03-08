class ProductsController < ApplicationController
  
  include Authenticable # Include authentication module
  before_action :authenticate_user! , only: [:create, :update]
  before_action :set_product, only: [:show, :update, :destroy]

  # GET /products
  def index
    # Rails.logger.info "Received Params: #{params.inspect}"
    # puts  params[:category]
    if params[:category]
    #  categories = Array.new(params[:category].is_a?(Array) ? params[:category] : params[:category].values)
     
    # if categories.length > 0
        @products = Product.where(category: params[:category])
        render json: @products.map { |product|
        ProductSerializer.new(product).serializable_hash[:data][:attributes]
      }
    else
        @products = Product.all
        render json: @products.map { |product|
        ProductSerializer.new(product).serializable_hash[:data][:attributes]
    }
    end    

  end

  # GET /products/:id
  def show

    render json: ProductSerializer.new(@product).serializable_hash[:data][:attributes]
  end

  # POST /products (with multiple images)
  def create
    # byebug
    @product = Product.new(product_params)

    if @product.save
    #   attach_images if params[:product][:product_image].present?
      render json: ProductSerializer.new(@product, meta: {
           message: "Product created successfully"
        }).serializable_hash[:data][:attributes], status: :created
    else
      render json: { errors: @product.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /products/:id
  def update
   
    if @product.update!(product_params)
      render json: ProductSerializer.new(@product).serializable_hash, status: :ok
    else
      render json: { errors: @product.errors.full_messages }, status: :unprocessable_entity
    end
  
  end

  # UNIQ categories
  def category_list
    @products = Product.select("DISTINCT ON (category) *").order(:category, created_at: :desc) 
    render json: @products.map { |product| 
    ProductSerializer.new(product).serializable_hash[:data][:attributes]
  }
  end

  def search
    query = params[:qstring].split('=>').last
    # puts 'q'
    # puts query
    if query.present?
      @products = Product.where("product_name ILIKE ? OR category ILIKE ?", "%#{query}%", "%#{query}%")
      render json: @products, status: :ok
    else
      render json: { error: "No query provided" }, status: :bad_request
    end
  end

  # filtered products
  def filter_products
    products = Product.all

    # Apply filters based on query params
    products = products.where("product_name ILIKE ?", "%#{params[:name]}%") if params[:name].present?
    products = products.where(category: params[:category]) if params[:category].present?
    products = products.where("price >= ?", params[:min_price]) if params[:min_price].present?
    products = products.where("price <= ?", params[:max_price]) if params[:max_price].present?
    products = products.where(brand_name: params[:brand]) if params[:brand].present?

    render json: products, status: :ok
  end
  # DELETE /products/:id
  def destroy
    @product.destroy
    head :no_content
  end

  private

  def set_product
    puts 'id:'
    puts params[:id]
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:product_name, :brand_name, :category, :description, :price, :selling_price, product_image: [])
  end

#   def attach_images
#     params[:product][:product_image].each do |image|
#       @product.product_image.attach(image)
#     end
#   end
end
