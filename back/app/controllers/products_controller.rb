class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :update, :destroy]

  # GET /products
  def index
    @products = Product.all
    render json: @products.map { |product| product_json_with_decompressed_img(product) }
  end

  # GET /products/:id
  def show
    render json: product_json_with_decompressed_img(@product)
  end

  # POST /products
  def create
    @product = Product.new(product_params)
  
    # Verifique e comprima a imagem
    if @product.product_img.present?
      unless @product.product_img.start_with?("data:image/")
        render json: { error: "Invalid image format" }, status: :unprocessable_entity
        return
      end
  
      @product.product_img = @product.compress_product_img(@product.product_img)
    end
  
    if @product.save
      render json: @product, status: :created
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end
  

  # PUT /products/:id
  def update
    if @product.update(product_params)
      render json: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # DELETE /products/:id
  def destroy
    @product.destroy
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:product_img, :product_name, :product_description, :product_value, :qty_available, :qty_sold)
  end

  def product_json_with_decompressed_img(product)
    product_hash = product.as_json
    if product.product_img.present?
      decompressed_img = product.decompress_product_img(product.product_img)
      product_hash["product_img"] = decompressed_img.start_with?("data:image/") ? decompressed_img : "data:image/png;base64," + decompressed_img
    end
    product_hash
  end  
end
